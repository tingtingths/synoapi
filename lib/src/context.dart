import 'dart:convert';
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:logging/logging.dart';

import 'api/query.dart';
import 'auth.dart';
import 'model.dart';

class LoggingInterceptor extends InterceptorsWrapper {

  final l = Logger('SynoAPI');

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    l.fine('> ${options.method} ${options.path}');
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    l.fine('< ${response.statusCode} ${response.data}');
    handler.next(response);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    l.fine('ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    handler.next(err);
  }
}

class APIContext {
  final String _proto;
  final String _authority;
  final String _endpoint;
  final Dio _client;
  Map<String, String> _appSid = {};
  Map<String, APIInfoQuery> _apiInfo = {};

  APIContext(String host, {String proto = 'https', int port = 443, String endpoint = '', String? proxy, })
      : _proto = proto,
        _authority = '$host:$port',
        _endpoint = endpoint,
        _client = Dio()..interceptors.add(LoggingInterceptor()) {
    if (proxy != null) {
      (_client.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (httpClient) {
        httpClient.findProxy = (uri) => proxy;
      };
    }
  }

  Uri buildUri(String path, Map<String, String?>? queryParams) {
    if (_proto == 'http') {
      return Uri.http(_authority, _endpoint + path, queryParams);
    } else if (_proto == 'https') {
      return Uri.https(_authority, _endpoint + path, queryParams);
    } else {
      throw Exception('Unsupported proto \'$proto\'');
    }
  }

  Future<bool> authApp(String app, String account, String passwd, {String? otpCode, Function? otpCallback}) async {
    var resp = await AuthAPIRaw(this).login(account, passwd, app, otpCode: otpCode, format: 'sid');
    var respObj = jsonDecode(resp.data!);
    if (respObj['success']) {
      _appSid[app] = respObj['data']['sid'];

      var apiInfo = await QueryAPI(this).info.apiInfo();
      if (!apiInfo.success) {
        throw Exception('Failed to query api info. error: ' +
            (apiInfo.error?.entries.map((e) => '${e.key}=${e.value}').join(',') ?? ''));
      }
      _apiInfo = apiInfo.data ?? {};

      return true;
    } else {
      print('authApp(); Authentication fail, code = ${respObj['error']['code']}');
      if (otpCallback != null && respObj['error']['code'] == 402) { // otp code required
        print('OTP Code = ${otpCallback()}');
        return authApp(app, account, passwd, otpCode: otpCallback());
      }
    }
    return false;
  }

  String get endpoint => _endpoint;

  String get authority => _authority;

  String get proto => _proto;

  Map<String, String> get appSid => _appSid;

  Dio get c => _client;

  Map<String, APIInfoQuery> get apiInfo => _apiInfo;

  int maxApiVersion(String apiName, {int defaultVersion = 1}) => _apiInfo[apiName]?.maxVersion ?? defaultVersion;

  int minApiVersion(String apiName, {int defaultVersion = 1}) => _apiInfo[apiName]?.minVersion ?? defaultVersion;
}
