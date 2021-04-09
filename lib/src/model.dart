import 'dart:convert';

import 'util/extension.dart';
import 'util/util.dart';

enum TaskStatus {
  waiting,
  downloading,
  paused,
  finishing,
  finished,
  hash_checking,
  seeding,
  filehosting_waiting,
  extracting,
  error
}

extension TaskStatusMembers on TaskStatus {
  String get name =>
      const {
        TaskStatus.waiting: 'waiting',
        TaskStatus.downloading: 'downloading',
        TaskStatus.paused: 'paused',
        TaskStatus.finishing: 'finishing',
        TaskStatus.finished: 'finished',
        TaskStatus.hash_checking: 'hash_checking',
        TaskStatus.seeding: 'seeding',
        TaskStatus.filehosting_waiting: 'filehosting_waiting',
        TaskStatus.extracting: 'extracting',
        TaskStatus.error: 'error',
      }[this] ??
      '';
}

class APIResponse<T> {
  final bool success;
  T? data;
  Map<String, dynamic>? error;
  String? _rawJson;

  APIResponse(this.success, this.data, this.error);

  APIResponse.fromJson(Map<String, dynamic>? json, T Function(dynamic data) create)
      : success = mapGet(json, 'success', otherwise: false) {
    if (json != null) {
      _rawJson = jsonEncode(json);
    }
    error = mapGet(json, 'error');
    data = mapGet(json, 'data', mapper: create);
  }

  String? get raw {
    return _rawJson;
  }
}

class APIInfoQuery {
  String? key;
  String? path;
  int? minVersion;
  int? maxVersion;

  APIInfoQuery.fromJson(Map<String, dynamic>? json) {
    key = mapGet(json, 'key');
    path = mapGet(json, 'path');
    minVersion = mapGet(json, 'minVersion');
    maxVersion = mapGet(json, 'maxVersion');
  }
}

class DownloadStationInfoGetInfo {
  int? version;
  String? versionString;
  bool? isManager;

  DownloadStationInfoGetInfo.fromJson(Map<String, dynamic> json) {
    version = mapGet(json, 'version');
    versionString = mapGet(json, 'version_string');
    isManager = mapGet(json, 'is_manager');
  }
}

class DownloadStationInfoGetConfig {
  int? btMaxDownload;
  int? btMaxUpload;
  int? emuleMaxDownload;
  int? emuleMaxUpload;
  int? nzbMaxDownload;
  int? httpMaxDownload;
  int? ftpMaxDownload;
  bool? emuleEnabled;
  bool? unzipServiceEnabled;
  String? defaultDestination;
  String? emuleDefaultDestination;

  DownloadStationInfoGetConfig.fromJson(Map<String, dynamic> json) {
    btMaxDownload = mapGet(json, 'bt_max_download');
    btMaxUpload = mapGet(json, 'bt_max_upload');
    emuleMaxDownload = mapGet(json, 'emule_max_download');
    emuleMaxUpload = mapGet(json, 'emule_max_upload');
    nzbMaxDownload = mapGet(json, 'nzb_max_download');
    httpMaxDownload = mapGet(json, 'http_max_download');
    ftpMaxDownload = mapGet(json, 'ftp_max_download');
    emuleEnabled = mapGet(json, 'emule_enabled');
    unzipServiceEnabled = mapGet(json, 'unzip_service_enabled');
    defaultDestination = mapGet(json, 'default_destination');
    emuleDefaultDestination = mapGet(json, 'emule_default_destination');
  }
}

class DownloadStationScheduleGetConfig {
  bool? enabled;
  bool? emuleEnabled;

  DownloadStationScheduleGetConfig.fromJson(Map<String, dynamic> json) {
    enabled = mapGet(json, 'enabled');
    emuleEnabled = mapGet(json, 'emule_enabled');
  }
}

class DownloadStationStatisticGetInfo {
  int? speedDownload;
  int? speedUpload;
  int? emuleSpeedDownload;
  int? emuleSpeedUpload;

  DownloadStationStatisticGetInfo.fromJson(Map<String, dynamic> json) {
    speedDownload = mapGet(json, 'speed_download');
    speedUpload = mapGet(json, 'speed_upload');
    emuleSpeedDownload = mapGet(json, 'emule_speed_download');
    emuleSpeedUpload = mapGet(json, 'emule_speed_upload');
  }
}

class _DownloadStationTaskActionResponse {
  String? id;
  int? error;

  _DownloadStationTaskActionResponse.fromJson(Map<String, dynamic> json) {
    id = mapGet(json, 'id');
    error = mapGet(json, 'error');
  }
}

class _DownloadStationMultiTaskActionResponse {
  List<_DownloadStationTaskActionResponse> responses = [];

  _DownloadStationMultiTaskActionResponse.fromJson(List<dynamic>? json) {
    if (json != null) {
      responses = json.map((el) {
        return _DownloadStationTaskActionResponse.fromJson(el);
      }).toList();
    }
  }
}

class DownloadStationTaskDelete extends _DownloadStationMultiTaskActionResponse {
  DownloadStationTaskDelete.fromJson(List<dynamic> json) : super.fromJson(json);
}

class DownloadStationTaskPause extends _DownloadStationMultiTaskActionResponse {
  DownloadStationTaskPause.fromJson(List<dynamic> json) : super.fromJson(json);
}

class DownloadStationTaskResume extends _DownloadStationMultiTaskActionResponse {
  DownloadStationTaskResume.fromJson(List<dynamic> json) : super.fromJson(json);
}

class DownloadStationTaskEdit extends _DownloadStationTaskActionResponse {
  DownloadStationTaskEdit.fromJson(Map<String, dynamic> json) : super.fromJson(json);
}

class ListTaskInfo {
  int total = 0;
  int offset = 0;
  List<Task> tasks = [];

  ListTaskInfo(this.total, this.offset, this.tasks);

  ListTaskInfo.fromJson(Map<String, dynamic> json) {
    total = mapGet(json, 'total');
    offset = mapGet(json, 'offset');

    tasks = mapGet(json, 'tasks', mapper: (List<dynamic> tasksJson) {
      return tasksJson.map((e) => Task.fromJson(jsonDecode(e))).toList();
    });
  }
}

class Task {
  String? id;
  String? type;
  String? username;
  String? title;
  int? size;
  String? _status;
  StatusExtra? statusExtra;
  Additional? additional;

  Task.fromJson(Map<String, dynamic> json) {
    id = mapGet(json, 'id');
    type = mapGet(json, 'type');
    username = mapGet(json, 'username');
    title = mapGet(json, 'title');
    size = mapGet(json, 'size');
    _status = mapGet(json, 'status');
    statusExtra = mapGet(json, 'status_extra', mapper: (val) => StatusExtra.fromJson(val));
    additional = mapGet(json, 'additional', mapper: (val) => Additional.fromJson(val));
  }

  set status(TaskStatus? status) {
    _status = status?.name;
  }

  TaskStatus? get status {
    if (_status == null) return null;
    if (_status!.equalsIgnoreCase(TaskStatus.waiting.name)) {
      return TaskStatus.waiting;
    }
    if (_status!.equalsIgnoreCase(TaskStatus.downloading.name)) {
      return TaskStatus.downloading;
    }
    if (_status!.equalsIgnoreCase(TaskStatus.paused.name)) {
      return TaskStatus.paused;
    }
    if (_status!.equalsIgnoreCase(TaskStatus.finishing.name)) {
      return TaskStatus.finishing;
    }
    if (_status!.equalsIgnoreCase(TaskStatus.finished.name)) {
      return TaskStatus.finished;
    }
    if (_status!.equalsIgnoreCase(TaskStatus.hash_checking.name)) {
      return TaskStatus.hash_checking;
    }
    if (_status!.equalsIgnoreCase(TaskStatus.seeding.name)) {
      return TaskStatus.seeding;
    }
    if (_status!.equalsIgnoreCase(TaskStatus.filehosting_waiting.name)) {
      return TaskStatus.filehosting_waiting;
    }
    if (_status!.equalsIgnoreCase(TaskStatus.extracting.name)) {
      return TaskStatus.extracting;
    }
    if (_status!.equalsIgnoreCase(TaskStatus.error.name)) {
      return TaskStatus.error;
    }
    return null;
  }
}

class Additional {
  TaskDetail? detail;
  TaskTransfer? transfer;
  List<TaskFile>? file;
  List<TaskTracker>? tracker;
  List<TaskPeer>? peer;

  Additional.fromJson(Map<String, dynamic> json) {
    detail = TaskDetail.fromJson(mapGet(json, 'detail'));
    transfer = TaskTransfer.fromJson(mapGet(json, 'transfer'));
    file = mapGet(json, 'file', mapper: (value) {
      return (value as List).map((e) => TaskFile.fromJson(e)).toList();
    });
    tracker = mapGet(json, 'tracker', mapper: (value) {
      return (value as List).map((e) => TaskTracker.fromJson(e)).toList();
    });
    peer = mapGet(json, 'peer', mapper: (value) {
      return (value as List).map((e) => TaskPeer.fromJson(e)).toList();
    });
  }
}

class StatusExtra {
  String? errorDetail;
  int? unzipProgress;

  StatusExtra.fromJson(Map<String, dynamic> json) {
    errorDetail = mapGet(json, 'error_detail');
    unzipProgress = mapGet(json, 'unzip_progress');
  }
}

class TaskDetail {
  String? destination;
  String? uri;
  DateTime? createTime;
  DateTime? startedTime;
  DateTime? completedTime;
  String? priority;
  int? totalPeers;
  int? connectedSeeders;
  int? connectedLeechers;
  int? connectedPeers;
  int? seedElapsed;
  String? unzipPassword;
  int? waitingSeconds;
  int? totalPieces;

  TaskDetail.fromJson(Map<String, dynamic> json) {
    destination = mapGet(json, 'destination');
    uri = mapGet(json, 'uri');

    // parse long timestamp
    createTime = mapGet(json, 'create_time', mapper: (ts) {
      return DateTime.fromMillisecondsSinceEpoch(ts * 1000);
    });
    startedTime = mapGet(json, 'started_time', mapper: (ts) {
      return DateTime.fromMillisecondsSinceEpoch(ts * 1000);
    });
    completedTime = mapGet(json, 'completed_time', mapper: (ts) {
      return DateTime.fromMillisecondsSinceEpoch(ts * 1000);
    });

    priority = mapGet(json, 'priority');
    totalPeers = mapGet(json, 'total_peers');
    connectedSeeders = mapGet(json, 'connected_seeders');
    connectedLeechers = mapGet(json, 'connected_leechers');
    connectedPeers = mapGet(json, 'connected_peers');
    seedElapsed = mapGet(json, 'seedelapsed');
    unzipPassword = mapGet(json, 'unzip_password');
    waitingSeconds = mapGet(json, 'waiting_seconds');
    totalPieces = mapGet(json, 'total_pieces');
  }
}

class TaskTransfer {
  int? downloadedPieces;
  int? sizeDownloaded;
  int? sizeUploaded;
  int? speedDownload;
  int? speedUpload;

  TaskTransfer.fromJson(Map<String, dynamic> json) {
    downloadedPieces = mapGet(json, 'downloaded_pieces');
    sizeDownloaded = mapGet(json, 'size_downloaded');
    sizeUploaded = mapGet(json, 'size_uploaded');
    speedDownload = mapGet(json, 'speed_download');
    speedUpload = mapGet(json, 'speed_upload');
  }
}

class TaskFile {
  String? filename;
  int? index;
  int? size;
  int? sizeDownloaded;
  String? priority;
  bool? wanted;

  TaskFile.fromJson(Map<String, dynamic> json) {
    filename = mapGet(json, 'filename');
    index = mapGet(json, 'index');
    size = mapGet(json, 'size');
    sizeDownloaded = mapGet(json, 'size_downloaded');
    priority = mapGet(json, 'priority');
    wanted = mapGet(json, 'wanted');
  }
}

class TaskTracker {
  String? url;
  String? status;
  int? updateTimer;
  int? seeds;
  int? peers;

  TaskTracker.fromJson(Map<String, dynamic> json) {
    url = mapGet(json, 'url');
    status = mapGet(json, 'status');
    updateTimer = mapGet(json, 'update_timer');
    seeds = mapGet(json, 'seeds');
    peers = mapGet(json, 'peers');
  }
}

class TaskPeer {
  String? address;
  String? agent;
  num? progress;
  int? speedDownload;
  int? speedUpload;

  TaskPeer.fromJson(Map<String, dynamic> json) {
    address = mapGet(json, 'address');
    agent = mapGet(json, 'agent');
    progress = mapGet(json, 'progress');
    speedDownload = mapGet(json, 'speed_download');
    speedUpload = mapGet(json, 'speed_upload');
  }
}

class DownloadStationRSSSiteList {
  int total = 0;
  int offset = 0;
  List<Site> sites = [];

  DownloadStationRSSSiteList.fromJson(Map<String, dynamic> json) {
    total = mapGet(json, 'total');
    offset = mapGet(json, 'offset');
    sites = mapGet(json, 'sites', mapper: (value) {
      return (value as List).map((e) => Site.fromJson(e)).toList();
    });
  }
}

class Site {
  int? id;
  bool? is_updating;
  String? title;
  String? url;
  DateTime? lastUpdate;
  String? username;

  Site.fromJson(Map<String, dynamic> json) {
    id = mapGet(json, 'id');
    is_updating = mapGet(json, 'is_updating');
    title = mapGet(json, 'title');
    url = mapGet(json, 'url');
    username = mapGet(json, 'username');
    lastUpdate = mapGet(json, 'last_update', mapper: (ts) {
      return DateTime.fromMillisecondsSinceEpoch(ts * 1000);
    });
  }
}
