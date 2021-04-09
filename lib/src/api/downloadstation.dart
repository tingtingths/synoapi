import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

import '../../synoapi.dart';
import '../const.dart';
import '../context.dart';
import '../model.dart' as model;

class DownloadStationAPI {
  final session = 'DownloadStation';
  final endpoint = '/webapi/DownloadStation';
  final APIContext _cntx;

  // sub APIs
  late final Info _info;
  late final Schedule _schedule;
  late final Task _task;

  DownloadStationAPI(this._cntx) {
    _info = Info(this);
    _schedule = Schedule(this);
    _task = Task(this);
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
}

class Info {
  final endpoint = '/info.cgi';
  final DownloadStationAPI _parentApi;

  Info(this._parentApi);

  Future<Response<String>> getInfoRaw({int? version}) async {
    final param = {
      'api': Syno.DownloadStation.Info,
      'version':
          version == null ? _parentApi._cntx.maxApiVersion(Syno.DownloadStation.Info).toString() : version.toString(),
      'method': 'getinfo',
      '_sid': _parentApi._cntx.appSid[_parentApi.session]
    };

    final uri = _parentApi._cntx.buildUri(_parentApi.endpoint + endpoint, param);
    return _parentApi._cntx.c.getUri(uri);
  }

  Future<model.APIResponse<model.DownloadStationInfoGetInfo>> getInfo({int? version}) async {
    return getInfoRaw(version: version).then((resp) {
      return model.APIResponse.fromJson(
          jsonDecode(resp.data!), (json) => model.DownloadStationInfoGetInfo.fromJson(json));
    });
  }

  Future<Response<String>> getConfigRaw({int? version}) async {
    final param = {
      'api': Syno.DownloadStation.Info,
      'version':
          version == null ? _parentApi._cntx.maxApiVersion(Syno.DownloadStation.Info).toString() : version.toString(),
      'method': 'getconfig',
      '_sid': _parentApi._cntx.appSid[_parentApi.session]
    };

    final uri = _parentApi._cntx.buildUri(_parentApi.session + endpoint, param);
    return _parentApi._cntx.c.getUri(uri);
  }

  Future<model.APIResponse<model.DownloadStationInfoGetConfig>> getConfig({int? version}) async {
    return getConfigRaw(version: version).then((resp) {
      return model.APIResponse.fromJson(
          jsonDecode(resp.data!), (json) => model.DownloadStationInfoGetConfig.fromJson(json));
    });
  }

  Future<Response<String>> setServerConfigRaw(Map<String, String> config, {int? version}) async {
    final param = {
      'api': Syno.DownloadStation.Info,
      'version':
          version == null ? _parentApi._cntx.maxApiVersion(Syno.DownloadStation.Info).toString() : version.toString(),
      'method': 'setserverconfig',
      '_sid': _parentApi._cntx.appSid[_parentApi.session]
    };
    param.addAll(config);
    param.removeWhere((key, value) => value == null);

    final uri = _parentApi._cntx.buildUri(_parentApi.session + endpoint, param);
    return _parentApi._cntx.c.getUri(uri);
  }

  Future<model.APIResponse<void>> setServerConfig(Map<String, String> config, {int? version}) async {
    return setServerConfigRaw(config, version: version).then((resp) {
      return model.APIResponse.fromJson(jsonDecode(resp.data!), (json) {});
    });
  }
}

class Schedule {
  final endpoint = '/schedule.cgi';
  final DownloadStationAPI _parentApi;

  Schedule(this._parentApi);

  Future<Response<String>> getConfigRaw({int? version}) async {
    final param = {
      'api': Syno.DownloadStation.Schedule,
      'version': version == null
          ? _parentApi._cntx.maxApiVersion(Syno.DownloadStation.Schedule).toString()
          : version.toString(),
      'method': 'getconfig',
      '_sid': _parentApi._cntx.appSid[_parentApi.session]
    };

    final uri = _parentApi._cntx.buildUri(_parentApi.endpoint + endpoint, param);
    return _parentApi._cntx.c.getUri(uri);
  }

  Future<model.APIResponse<model.DownloadStationScheduleGetConfig>> scheduleGetConfig({int? version}) async {
    return getConfigRaw(version: version).then((resp) {
      return model.APIResponse.fromJson(
          jsonDecode(resp.data!), (json) => model.DownloadStationScheduleGetConfig.fromJson(json));
    });
  }

  Future<Response<String>> setConfigRaw(bool enabled, bool emuleEnabled, {int? version}) async {
    final param = {
      'enabled': enabled.toString(),
      'emule_enabled': emuleEnabled.toString(),
      'api': Syno.DownloadStation.Schedule,
      'version': version == null
          ? _parentApi._cntx.maxApiVersion(Syno.DownloadStation.Schedule).toString()
          : version.toString(),
      'method': 'setconfig',
      '_sid': _parentApi._cntx.appSid[_parentApi.session]
    };

    final uri = _parentApi._cntx.buildUri(_parentApi.endpoint + endpoint, param);
    return _parentApi._cntx.c.getUri(uri);
  }

  Future<model.APIResponse<void>> scheduleSetConfig(bool enabled, bool emuleEnabled, {int? version}) async {
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
      List<String> additional = const ['detail', 'transfer', 'file', 'tracker', 'peer']}) async {
    final param = {
      'offset': offset.toString(),
      'limit': limit.toString(),
      'additional': additional.join(','),
      // detail, transfer, file, tracker, peer
      'api': Syno.DownloadStation.Task,
      'version': version == null ? _cntx.maxApiVersion(Syno.DownloadStation.Task).toString() : version.toString(),
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
      List<String> additional = const ['detail', 'transfer', 'file', 'tracker', 'peer']}) async {
    return listRaw(version: version, offset: offset, limit: limit, additional: additional).then((resp) {
      return model.APIResponse<model.ListTaskInfo>.fromJson(jsonDecode(resp.data!), (data) {
        return model.ListTaskInfo.fromJson(data);
      });
    });
  }

  Future<Response<String>> getInfoRaw(List<String> ids,
      {int? version, List<String> additional = const ['detail', 'transfer', 'file', 'tracker', 'peer']}) async {
    final param = {
      'id': ids.join(','),
      'additional': additional.join(','),
      // detail, transfer, file, tracker, peer
      'api': Syno.DownloadStation.Task,
      'version': version == null ? _cntx.maxApiVersion(Syno.DownloadStation.Task).toString() : version.toString(),
      'method': 'getinfo',
      '_sid': _cntx.appSid[_parentApi.session]
    };

    final uri = _cntx.buildUri(_parentApi.endpoint + endpoint, param);

    return _cntx.c.getUri(uri);
  }

  Future<model.APIResponse<List<model.Task>>> getInfo(List<String> ids,
      {int? version, List<String> additional = const ['detail', 'transfer', 'file', 'tracker', 'peer']}) async {
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
      'version': version == null ? _cntx.maxApiVersion(Syno.DownloadStation.Task).toString() : version.toString(),
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
      String? destination}) async {
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

  Future<Response<String>> deleteRaw(List<String> ids, bool forceComplete, {int? version}) async {
    final param = {
      'id': ids.join(','),
      'force_complete': forceComplete.toString(),
      'api': Syno.DownloadStation.Task,
      'version': version == null ? _cntx.maxApiVersion(Syno.DownloadStation.Task).toString() : version.toString(),
      'method': 'delete',
      '_sid': _cntx.appSid[_parentApi.session]
    };

    final uri = _cntx.buildUri(_parentApi.endpoint + endpoint, param);
    return _cntx.c.getUri(uri);
  }

  Future<model.APIResponse<model.DownloadStationTaskDelete>> delete(List<String> ids, bool forceComplete,
      {int? version}) async {
    return deleteRaw(ids, forceComplete, version: version).then((resp) {
      return model.APIResponse.fromJson(
          jsonDecode(resp.data!), (json) => model.DownloadStationTaskDelete.fromJson(json));
    });
  }

  Future<Response<String>> pauseRaw(List<String> ids, {int? version}) async {
    final param = {
      'id': ids.join(','),
      'api': Syno.DownloadStation.Task,
      'version': version == null ? _cntx.maxApiVersion(Syno.DownloadStation.Task).toString() : version.toString(),
      'method': 'pause',
      '_sid': _cntx.appSid[_parentApi.session]
    };

    final uri = _cntx.buildUri(_parentApi.endpoint + endpoint, param);
    return _cntx.c.getUri(uri);
  }

  Future<model.APIResponse<model.DownloadStationTaskPause>> pause(List<String> ids, {int? version}) async {
    return pauseRaw(ids, version: version).then((resp) {
      return model.APIResponse.fromJson(
          jsonDecode(resp.data!), (json) => model.DownloadStationTaskPause.fromJson(json));
    });
  }

  Future<Response<String>> resumeRaw(List<String> ids, {int? version}) async {
    final param = {
      'id': ids.join(','),
      'api': Syno.DownloadStation.Task,
      'version': version == null ? _cntx.maxApiVersion(Syno.DownloadStation.Task).toString() : version.toString(),
      'method': 'resume',
      '_sid': _cntx.appSid[_parentApi.session]
    };

    final uri = _cntx.buildUri(_parentApi.endpoint + endpoint, param);
    return _cntx.c.getUri(uri);
  }

  Future<model.APIResponse<model.DownloadStationTaskResume>> resume(List<String> ids, {int? version}) async {
    return resumeRaw(ids, version: version).then((resp) {
      return model.APIResponse.fromJson(
          jsonDecode(resp.data!), (json) => model.DownloadStationTaskResume.fromJson(json));
    });
  }

  Future<Response<String>> editRaw(List<String> ids, {String? destination, int? version}) async {
    final param = {
      'id': ids.join(','),
      'destination': destination,
      'api': Syno.DownloadStation.Task,
      'version': version == null ? _cntx.maxApiVersion(Syno.DownloadStation.Task).toString() : version.toString(),
      'method': 'edit',
      '_sid': _cntx.appSid[_parentApi.session]
    };
    param.removeWhere((key, value) => value == null);

    final uri = _cntx.buildUri(_parentApi.endpoint + endpoint, param);
    return _cntx.c.getUri(uri);
  }

  Future<model.APIResponse<model.DownloadStationTaskEdit>> taskEdit(List<String> ids,
      {String? destination, int? version}) async {
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

  Future<Response<String>> getInfoRaw({int? version}) async {
    final param = {
      'api': Syno.DownloadStation.Statistic,
      'version': version == null ? _cntx.maxApiVersion(Syno.DownloadStation.Statistic).toString() : version.toString(),
      'method': 'getinfo',
      '_sid': _cntx.appSid[_parentApi.session]
    };

    final uri = _cntx.buildUri(_parentApi.endpoint + endpoint, param);
    return _cntx.c.getUri(uri);
  }

  Future<model.APIResponse<model.DownloadStationStatisticGetInfo>> statGetInfo({int? version}) async {
    return getInfoRaw(version: version).then((resp) {
      return model.APIResponse.fromJson(
          jsonDecode(resp.data!), (json) => model.DownloadStationStatisticGetInfo.fromJson(json));
    });
  }
}
