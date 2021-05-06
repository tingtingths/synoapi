import 'dart:convert';

import 'package:dio/dio.dart';

import '../../synoapi.dart';
import '../const.dart';
import '../context.dart';
import '../model.dart';

class QueryAPI {
  final endpoint = '/webapi/query.cgi';
  final APIContext _cntx;

  // sub API
  late final Info _info;

  QueryAPI(this._cntx) {
    _info = Info(this);
  }

  Info get info {
    return _info;
  }
}

class Info {
  final QueryAPI _parentApi;
  final APIContext _cntx;

  Info(this._parentApi) : _cntx = _parentApi._cntx;

  Future<Response<String>> apiInfoRaw({int? version, String query = 'all'}) async {
    final param = {
      'api': Syno.API.Info,
      'version':
          version == null ? _cntx.maxApiVersion(Syno.API.Info, defaultVersion: 1).toString() : version.toString(),
      'query': query,
      'method': 'query'
    };

    final uri = _cntx.buildUri(_parentApi.endpoint, param);
    return _cntx.c.getUri(uri);
  }

  Future<APIResponse<Map<String, APIInfoQuery>>> apiInfo({int? version, String query = 'all'}) async {
    return apiInfoRaw(version: version).then((resp) {
      return APIResponse<Map<String, APIInfoQuery>>.fromJson(jsonDecode(resp.data!), (data) {
        var result = <String, APIInfoQuery>{};
        data.forEach((key, value) {
          result[key] = APIInfoQuery.fromJson(value);
        });
        return result;
      });
    });
  }
}
