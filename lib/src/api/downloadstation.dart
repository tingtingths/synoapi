import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:logging/logging.dart';

import '../../synoapi.dart';
import '../const.dart';
import '../context.dart';
import '../model.dart' as model;

final l = Logger('DownloadStation');

class DownloadStationAPI {
  final session = 'DownloadStation';
  final endpoint = '/webapi/DownloadStation';
  final APIContext _cntx;

  // sub APIs
  late final Info _info;
  late final Schedule _schedule;
  late final Task _task;
  late final RSS _rss;

  DownloadStationAPI(this._cntx) {
    _info = Info(this);
    _schedule = Schedule(this);
    _task = Task(this);
    _rss = RSS(this);
  }

  Info get info {
    return _info;
  }

  Schedule get schedule {
    return _schedule;
  }

  Task get task {
    return _task;
  }

  RSS get rss {
    return _rss;
  }
}

class Info {
  final endpoint = '/info.cgi';
  final DownloadStationAPI _parentApi;

  Info(this._parentApi);

  Future<Response<String>> getInfoRaw({int? version}) {
    final param = {
      'api': Syno.DownloadStation.Info,
      'version': version?.toString() ?? _parentApi._cntx.maxApiVersion(Syno.DownloadStation.Info).toString(),
      'method': 'getinfo',
      '_sid': _parentApi._cntx.appSid[_parentApi.session]
    };

    final uri = _parentApi._cntx.buildUri(_parentApi.endpoint + endpoint, param);
    return _parentApi._cntx.c.getUri(uri);
  }

  Future<model.APIResponse<model.DownloadStationInfoGetInfo>> getInfo({int? version}) {
    return getInfoRaw(version: version).then((resp) {
      return model.APIResponse.fromJson(
          jsonDecode(resp.data!), (json) => model.DownloadStationInfoGetInfo.fromJson(json));
    });
  }

  Future<Response<String>> getConfigRaw({int? version}) {
    final param = {
      'api': Syno.DownloadStation.Info,
      'version': version?.toString() ?? _parentApi._cntx.maxApiVersion(Syno.DownloadStation.Info).toString(),
      'method': 'getconfig',
      '_sid': _parentApi._cntx.appSid[_parentApi.session]
    };

    final uri = _parentApi._cntx.buildUri(_parentApi.session + endpoint, param);
    return _parentApi._cntx.c.getUri(uri);
  }

  Future<model.APIResponse<model.DownloadStationInfoGetConfig>> getConfig({int? version}) {
    return getConfigRaw(version: version).then((resp) {
      return model.APIResponse.fromJson(
          jsonDecode(resp.data!), (json) => model.DownloadStationInfoGetConfig.fromJson(json));
    });
  }

  Future<Response<String>> setServerConfigRaw(Map<String, String> config, {int? version}) {
    final param = {
      'api': Syno.DownloadStation.Info,
      'version': version?.toString() ?? _parentApi._cntx.maxApiVersion(Syno.DownloadStation.Info).toString(),
      'method': 'setserverconfig',
      '_sid': _parentApi._cntx.appSid[_parentApi.session]
    };
    param.addAll(config);
    param.removeWhere((key, value) => value == null);

    final uri = _parentApi._cntx.buildUri(_parentApi.session + endpoint, param);
    return _parentApi._cntx.c.getUri(uri);
  }

  Future<model.APIResponse<void>> setServerConfig(Map<String, String> config, {int? version}) {
    return setServerConfigRaw(config, version: version).then((resp) {
      return model.APIResponse.fromJson(jsonDecode(resp.data!), (json) {});
    });
  }
}

class Schedule {
  final endpoint = '/schedule.cgi';
  final DownloadStationAPI _parentApi;

  Schedule(this._parentApi);

  Future<Response<String>> getConfigRaw({int? version}) {
    final param = {
      'api': Syno.DownloadStation.Schedule,
      'version': version?.toString() ?? _parentApi._cntx.maxApiVersion(Syno.DownloadStation.Schedule).toString(),
      'method': 'getconfig',
      '_sid': _parentApi._cntx.appSid[_parentApi.session]
    };

    final uri = _parentApi._cntx.buildUri(_parentApi.endpoint + endpoint, param);
    return _parentApi._cntx.c.getUri(uri);
  }

  Future<model.APIResponse<model.DownloadStationScheduleGetConfig>> scheduleGetConfig({int? version}) {
    return getConfigRaw(version: version).then((resp) {
      return model.APIResponse.fromJson(
          jsonDecode(resp.data!), (json) => model.DownloadStationScheduleGetConfig.fromJson(json));
    });
  }

  Future<Response<String>> setConfigRaw(bool enabled, bool emuleEnabled, {int? version}) {
    final param = {
      'enabled': enabled.toString(),
      'emule_enabled': emuleEnabled.toString(),
      'api': Syno.DownloadStation.Schedule,
      'version': version?.toString() ?? _parentApi._cntx.maxApiVersion(Syno.DownloadStation.Schedule).toString(),
      'method': 'setconfig',
      '_sid': _parentApi._cntx.appSid[_parentApi.session]
    };

    final uri = _parentApi._cntx.buildUri(_parentApi.endpoint + endpoint, param);
    return _parentApi._cntx.c.getUri(uri);
  }

  Future<model.APIResponse<void>> scheduleSetConfig(bool enabled, bool emuleEnabled, {int? version}) {
    return setConfigRaw(enabled, emuleEnabled, version: version).then((resp) {
      return model.APIResponse.fromJson(jsonDecode(resp.data!), (json) {});
    });
  }
}

class Task {
  final endpoint = '/task.cgi';
  final DownloadStationAPI _parentApi;
  final APIContext _cntx;

  Task(this._parentApi) : _cntx = _parentApi._cntx;

  Future<Response<String>> listRaw(
      {int? version,
      int offset = 0,
      int limit = -1,
      List<String> additional = const ['detail', 'transfer', 'file', 'tracker', 'peer']}) {
    final param = {
      'offset': offset.toString(),
      'limit': limit.toString(),
      'additional': additional.join(','),
      // detail, transfer, file, tracker, peer
      'api': Syno.DownloadStation.Task,
      'version': version?.toString() ?? _cntx.maxApiVersion(Syno.DownloadStation.Task).toString(),
      'method': 'list',
      '_sid': _cntx.appSid[_parentApi.session]
    };

    final uri = _cntx.buildUri(_parentApi.endpoint + endpoint, param);
    return _cntx.c.getUri(uri);
  }

  Future<model.APIResponse<model.ListTaskInfo>> list(
      {int? version,
      int offset = 0,
      int limit = -1,
      List<String> additional = const ['detail', 'transfer', 'file', 'tracker', 'peer']}) {
    return listRaw(version: version, offset: offset, limit: limit, additional: additional).then((resp) {
      return model.APIResponse<model.ListTaskInfo>.fromJson(jsonDecode(resp.data!), (data) {
        return model.ListTaskInfo.fromJson(data);
      });
    });
  }

  Future<Response<String>> getInfoRaw(List<String> ids,
      {int? version, List<String> additional = const ['detail', 'transfer', 'file', 'tracker', 'peer']}) {
    final param = {
      'id': ids.join(','),
      'additional': additional.join(','),
      // detail, transfer, file, tracker, peer
      'api': Syno.DownloadStation.Task,
      'version': version?.toString() ?? _cntx.maxApiVersion(Syno.DownloadStation.Task).toString(),
      'method': 'getinfo',
      '_sid': _cntx.appSid[_parentApi.session]
    };

    final uri = _cntx.buildUri(_parentApi.endpoint + endpoint, param);

    return _cntx.c.getUri(uri);
  }

  Future<model.APIResponse<List<model.Task>>> getInfo(List<String> ids,
      {int? version, List<String> additional = const ['detail', 'transfer', 'file', 'tracker', 'peer']}) {
    return getInfoRaw(ids, version: version, additional: additional).then((resp) {
      return model.APIResponse.fromJson(jsonDecode(resp.data!), (json) {
        if (json.containsKey('tasks')) {
          List<dynamic> tasks = (json ?? {})['tasks'];
          return tasks.map((e) => model.Task.fromJson(e)).toList();
        }
        return [];
      });
    });
  }

  Future<Response<String>> createRaw(
      {int? version,
      List<String>? uris,
      File? file,
      String? username,
      String? passwd,
      String? unzipPasswd,
      String? destination}) async {
    final param = {
      'uri': uris?.join(','),
      'username': username,
      'password': passwd,
      'unzip_password': unzipPasswd,
      'destination': destination,
      'api': Syno.DownloadStation.Task,
      'version': version?.toString() ?? _cntx.maxApiVersion(Syno.DownloadStation.Task).toString(),
      'method': 'create',
      '_sid': _cntx.appSid[_parentApi.session]
    };
    param.removeWhere((key, value) => value == null);

    final uri = _cntx.buildUri(_parentApi.endpoint + endpoint, null);

    dynamic data = FormData.fromMap(param);
    if (file != null && !file.existsSync()) {
      throw Exception('File not found');
    }

    var options;
    if (file != null) {
      data.files.add(MapEntry('file', await MultipartFile.fromFile(file.path)));
    } else {
      // if not using file, send as x-www-form-urlencoded
      data = param;
      options = Options(contentType: Headers.formUrlEncodedContentType);
    }

    return _cntx.c.postUri(uri, data: data, options: options);
  }

  Future<model.APIResponse<void>> create(
      {int? version,
      List<String>? uris,
      File? file,
      String? username,
      String? passwd,
      String? unzipPasswd,
      String? destination}) {
    return createRaw(
            version: version,
            uris: uris,
            file: file,
            username: username,
            passwd: passwd,
            unzipPasswd: unzipPasswd,
            destination: destination)
        .then((resp) {
      return model.APIResponse.fromJson(jsonDecode(resp.data!), (json) {});
    });
  }

  Future<Response<String>> deleteRaw(List<String> ids, bool forceComplete, {int? version}) {
    final param = {
      'id': ids.join(','),
      'force_complete': forceComplete.toString(),
      'api': Syno.DownloadStation.Task,
      'version': version?.toString() ?? _cntx.maxApiVersion(Syno.DownloadStation.Task).toString(),
      'method': 'delete',
      '_sid': _cntx.appSid[_parentApi.session]
    };

    final uri = _cntx.buildUri(_parentApi.endpoint + endpoint, param);
    return _cntx.c.getUri(uri);
  }

  Future<model.APIResponse<model.DownloadStationTaskDelete>> delete(List<String> ids, bool forceComplete,
      {int? version}) {
    return deleteRaw(ids, forceComplete, version: version).then((resp) {
      return model.APIResponse.fromJson(
          jsonDecode(resp.data!), (json) => model.DownloadStationTaskDelete.fromJson(json));
    });
  }

  Future<Response<String>> pauseRaw(List<String> ids, {int? version}) {
    final param = {
      'id': ids.join(','),
      'api': Syno.DownloadStation.Task,
      'version': version?.toString() ?? _cntx.maxApiVersion(Syno.DownloadStation.Task).toString(),
      'method': 'pause',
      '_sid': _cntx.appSid[_parentApi.session]
    };

    final uri = _cntx.buildUri(_parentApi.endpoint + endpoint, param);
    return _cntx.c.getUri(uri);
  }

  Future<model.APIResponse<model.DownloadStationTaskPause>> pause(List<String> ids, {int? version}) {
    return pauseRaw(ids, version: version).then((resp) {
      return model.APIResponse.fromJson(
          jsonDecode(resp.data!), (json) => model.DownloadStationTaskPause.fromJson(json));
    });
  }

  Future<Response<String>> resumeRaw(List<String> ids, {int? version}) {
    final param = {
      'id': ids.join(','),
      'api': Syno.DownloadStation.Task,
      'version': version?.toString() ?? _cntx.maxApiVersion(Syno.DownloadStation.Task).toString(),
      'method': 'resume',
      '_sid': _cntx.appSid[_parentApi.session]
    };

    final uri = _cntx.buildUri(_parentApi.endpoint + endpoint, param);
    return _cntx.c.getUri(uri);
  }

  Future<model.APIResponse<model.DownloadStationTaskResume>> resume(List<String> ids, {int? version}) {
    return resumeRaw(ids, version: version).then((resp) {
      return model.APIResponse.fromJson(
          jsonDecode(resp.data!), (json) => model.DownloadStationTaskResume.fromJson(json));
    });
  }

  Future<Response<String>> editRaw(List<String> ids, {String? destination, int? version}) {
    final param = {
      'id': ids.join(','),
      'destination': destination,
      'api': Syno.DownloadStation.Task,
      'version': version?.toString() ?? _cntx.maxApiVersion(Syno.DownloadStation.Task).toString(),
      'method': 'edit',
      '_sid': _cntx.appSid[_parentApi.session]
    };
    param.removeWhere((key, value) => value == null);

    final uri = _cntx.buildUri(_parentApi.endpoint + endpoint, param);
    return _cntx.c.getUri(uri);
  }

  Future<model.APIResponse<model.DownloadStationTaskEdit>> taskEdit(List<String> ids,
      {String? destination, int? version}) {
    return editRaw(ids, destination: destination, version: version).then((resp) {
      return model.APIResponse.fromJson(jsonDecode(resp.data!), (json) => model.DownloadStationTaskEdit.fromJson(json));
    });
  }
}

class Statistic {
  final endpoint = '/statistic.cgi';
  final DownloadStationAPI _parentApi;
  late final APIContext _cntx;

  Statistic(this._parentApi) : _cntx = _parentApi._cntx;

  Future<Response<String>> getInfoRaw({int? version}) {
    final param = {
      'api': Syno.DownloadStation.Statistic,
      'version': version?.toString() ?? _cntx.maxApiVersion(Syno.DownloadStation.Statistic).toString(),
      'method': 'getinfo',
      '_sid': _cntx.appSid[_parentApi.session]
    };

    final uri = _cntx.buildUri(_parentApi.endpoint + endpoint, param);
    return _cntx.c.getUri(uri);
  }

  Future<model.APIResponse<model.DownloadStationStatisticGetInfo>> statGetInfo({int? version}) {
    return getInfoRaw(version: version).then((resp) {
      return model.APIResponse.fromJson(
          jsonDecode(resp.data!), (json) => model.DownloadStationStatisticGetInfo.fromJson(json));
    });
  }
}

class RSS {
  final DownloadStationAPI _parentApi;
  late final APIContext _cntx;
  late final session;
  late final endpoint;

  // sub APIs
  late final _site;
  late final _feed;

  RSS(this._parentApi)
      : _cntx = _parentApi._cntx,
        session = _parentApi.session,
        endpoint = _parentApi.endpoint {
    _site = RSSSite(this);
    _feed = RSSFeed(this);
  }

  RSSSite get site {
    return _site;
  }

  RSSFeed get feed {
    return _feed;
  }
}

class RSSSite {
  final RSS _parentApi;
  final endpoint = '/RSSSite.cgi';
  late final APIContext _cntx;

  RSSSite(this._parentApi) : _cntx = _parentApi._cntx;

  Future<Response<String>> listRaw({int? offset, int? limit, int? version}) {
    final param = {
      'offset': offset?.toString(),
      'limit': limit?.toString(),
      'api': Syno.DownloadStation.RSS.Site,
      'version': version?.toString() ?? _cntx.maxApiVersion(Syno.DownloadStation.RSS.Site).toString(),
      'method': 'list',
      '_sid': _cntx.appSid[_parentApi.session]
    };

    final uri = _cntx.buildUri(_parentApi.endpoint + endpoint, param);
    return _cntx.c.getUri(uri);
  }

  Future<model.APIResponse<model.DownloadStationRSSSiteList>> list({int? offset, int? limit, int? version}) {
    return listRaw(offset: offset, limit: limit, version: version).then((resp) {
      return model.APIResponse.fromJson(
          jsonDecode(resp.data!), (data) => model.DownloadStationRSSSiteList.fromJson(data));
    });
  }

  Future<Response<String>> refreshRaw(List<String> ids, {int? version}) {
    final param = {
      'id': ids.join(','),
      'api': Syno.DownloadStation.RSS.Site,
      'version': version?.toString() ?? _cntx.maxApiVersion(Syno.DownloadStation.RSS.Site).toString(),
      'method': 'refresh',
      '_sid': _cntx.appSid[_parentApi.session]
    };

    final uri = _cntx.buildUri(_parentApi.endpoint + endpoint, param);
    return _cntx.c.getUri(uri);
  }

  Future<model.APIResponse<Null>> refresh(List<String> ids, {int? version}) {
    return refreshRaw(ids, version: version).then((resp) {
      return model.APIResponse.fromJson(jsonDecode(resp.data!), (data) => null);
    });
  }
}

class RSSFeed {
  final RSS _parentApi;
  final endpoint = '/RSSFeed.cgi';
  late final _cntx;

  RSSFeed(this._parentApi) : _cntx = _parentApi._cntx;
}
