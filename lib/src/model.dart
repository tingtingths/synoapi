/*
API response model.
run 'dart run build_runner build' to generate json class.
 */
import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import 'util/extension.dart';
import 'util/util.dart';

part 'model.g.dart';

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

@JsonSerializable()
class APIInfoQuery {
  String? key;
  String? path;
  int? minVersion;
  int? maxVersion;

  APIInfoQuery(this.key, this.path, this.minVersion, this.maxVersion);

  factory APIInfoQuery.fromJson(Map<String, dynamic> json) => _$APIInfoQueryFromJson(json);

  Map<String, dynamic> toJson() => _$APIInfoQueryToJson(this);
}

@JsonSerializable()
class DownloadStationInfoGetInfo {
  int? version;
  @JsonKey(name: 'version_string')
  String? versionString;
  @JsonKey(name: 'is_manager')
  bool? isManager;

  DownloadStationInfoGetInfo(this.version, this.versionString, this.isManager);

  factory DownloadStationInfoGetInfo.fromJson(Map<String, dynamic> json) => _$DownloadStationInfoGetInfoFromJson(json);

  Map<String, dynamic> toJson() => _$DownloadStationInfoGetInfoToJson(this);
}

@JsonSerializable()
class DownloadStationInfoGetConfig {
  @JsonKey(name: 'bt_max_download')
  int? btMaxDownload;
  @JsonKey(name: 'bt_max_upload')
  int? btMaxUpload;
  @JsonKey(name: 'emule_max_download')
  int? emuleMaxDownload;
  @JsonKey(name: 'emule_max_upload')
  int? emuleMaxUpload;
  @JsonKey(name: 'nzb_max_download')
  int? nzbMaxDownload;
  @JsonKey(name: 'http_max_download')
  int? httpMaxDownload;
  @JsonKey(name: 'ftp_max_download')
  int? ftpMaxDownload;
  @JsonKey(name: 'emule_enabled')
  bool? emuleEnabled;
  @JsonKey(name: 'unzip_service_enabled')
  bool? unzipServiceEnabled;
  @JsonKey(name: 'default_destination')
  String? defaultDestination;
  @JsonKey(name: 'emule_default_destination')
  String? emuleDefaultDestination;

  DownloadStationInfoGetConfig(
      this.btMaxDownload,
      this.btMaxUpload,
      this.emuleMaxDownload,
      this.emuleMaxUpload,
      this.nzbMaxDownload,
      this.httpMaxDownload,
      this.ftpMaxDownload,
      this.emuleEnabled,
      this.unzipServiceEnabled,
      this.defaultDestination,
      this.emuleDefaultDestination);

  factory DownloadStationInfoGetConfig.fromJson(Map<String, dynamic> json) =>
      _$DownloadStationInfoGetConfigFromJson(json);

  Map<String, dynamic> toJson() => _$DownloadStationInfoGetConfigToJson(this);
}

@JsonSerializable()
class DownloadStationScheduleGetConfig {
  bool? enabled;
  @JsonKey(name: 'emule_enabled')
  bool? emuleEnabled;

  DownloadStationScheduleGetConfig(this.enabled, this.emuleEnabled);

  factory DownloadStationScheduleGetConfig.fromJson(Map<String, dynamic> json) =>
      _$DownloadStationScheduleGetConfigFromJson(json);

  Map<String, dynamic> toJson() => _$DownloadStationScheduleGetConfigToJson(this);
}

@JsonSerializable()
class DownloadStationStatisticGetInfo {
  @JsonKey(name: 'speed_download')
  int? speedDownload;
  @JsonKey(name: 'speed_upload')
  int? speedUpload;
  @JsonKey(name: 'emule_speed_download')
  int? emuleSpeedDownload;
  @JsonKey(name: 'emule_speed_upload')
  int? emuleSpeedUpload;

  DownloadStationStatisticGetInfo(this.speedDownload, this.speedUpload, this.emuleSpeedDownload, this.emuleSpeedUpload);

  factory DownloadStationStatisticGetInfo.fromJson(Map<String, dynamic> json) =>
      _$DownloadStationStatisticGetInfoFromJson(json);

  Map<String, dynamic> toJson() => _$DownloadStationStatisticGetInfoToJson(this);
}

@JsonSerializable()
class _DownloadStationTaskActionResponse {
  String? id;
  int? error;

  _DownloadStationTaskActionResponse(this.id, this.error);

  factory _DownloadStationTaskActionResponse.fromJson(Map<String, dynamic> json) =>
      _$_DownloadStationTaskActionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$_DownloadStationTaskActionResponseToJson(this);
}

class _DownloadStationMultiTaskActionResponse {
  List<_DownloadStationTaskActionResponse> responses = [];

  _DownloadStationMultiTaskActionResponse(this.responses);

  factory _DownloadStationMultiTaskActionResponse.fromJson(List<dynamic>? json) {
    if (json != null) {
      return _DownloadStationMultiTaskActionResponse(json.map((el) {
        return _DownloadStationTaskActionResponse.fromJson(el);
      }).toList());
    }
    return _DownloadStationMultiTaskActionResponse([]);
  }
}

class DownloadStationTaskDelete extends _DownloadStationMultiTaskActionResponse {
  DownloadStationTaskDelete(_DownloadStationMultiTaskActionResponse superObj) : super(superObj.responses);

  factory DownloadStationTaskDelete.fromJson(List<dynamic> json) {
    return DownloadStationTaskDelete(_DownloadStationMultiTaskActionResponse.fromJson(json));
  }
}

class DownloadStationTaskPause extends _DownloadStationMultiTaskActionResponse {
  DownloadStationTaskPause(_DownloadStationMultiTaskActionResponse superObj) : super(superObj.responses);

  factory DownloadStationTaskPause.fromJson(List<dynamic> json) {
    return DownloadStationTaskPause(_DownloadStationMultiTaskActionResponse.fromJson(json));
  }
}

class DownloadStationTaskResume extends _DownloadStationMultiTaskActionResponse {
  DownloadStationTaskResume(_DownloadStationMultiTaskActionResponse superObj) : super(superObj.responses);

  factory DownloadStationTaskResume.fromJson(List<dynamic> json) {
    return DownloadStationTaskResume(_DownloadStationMultiTaskActionResponse.fromJson(json));
  }
}

class DownloadStationTaskEdit extends _DownloadStationTaskActionResponse {
  DownloadStationTaskEdit(_DownloadStationTaskActionResponse superObj) : super(superObj.id, superObj.error);

  factory DownloadStationTaskEdit.fromJson(Map<String, dynamic> json) {
    return DownloadStationTaskEdit(_DownloadStationTaskActionResponse.fromJson(json));
  }
}

@JsonSerializable()
class ListTaskInfo {
  int total = 0;
  int offset = 0;
  List<Task> tasks = [];

  ListTaskInfo(this.total, this.offset, this.tasks);

  factory ListTaskInfo.fromJson(Map<String, dynamic> json) => _$ListTaskInfoFromJson(json);

  Map<String, dynamic> toJson() => _$ListTaskInfoToJson(this);
}

@JsonSerializable()
class Task {
  String? id;
  String? type;
  String? username;
  String? title;
  int? size;
  String? _status;
  @JsonKey(name: 'status_extra')
  StatusExtra? statusExtra;
  Additional? additional;

  Task(this.id, this.type, this.username, this.title, this.size, TaskStatus? status, this.statusExtra, this.additional)
      : _status = status?.name;

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  Map<String, dynamic> toJson() => _$TaskToJson(this);

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

@JsonSerializable()
class Additional {
  TaskDetail? detail;
  TaskTransfer? transfer;
  List<TaskFile>? file;
  List<TaskTracker>? tracker;
  List<TaskPeer>? peer;

  Additional(this.detail, this.transfer, this.file, this.tracker, this.peer);

  factory Additional.fromJson(Map<String, dynamic> json) => _$AdditionalFromJson(json);

  Map<String, dynamic> toJson() => _$AdditionalToJson(this);
}

@JsonSerializable()
class StatusExtra {
  @JsonKey(name: 'error_detail')
  String? errorDetail;
  @JsonKey(name: 'unzip_progress')
  int? unzipProgress;

  StatusExtra(this.errorDetail, this.unzipProgress);

  factory StatusExtra.fromJson(Map<String, dynamic> json) => _$StatusExtraFromJson(json);

  Map<String, dynamic> toJson() => _$StatusExtraToJson(this);
}

@JsonSerializable()
@DateTimeEpochConverter()
class TaskDetail {
  String? destination;
  String? uri;
  @JsonKey(name: 'create_time')
  DateTime? createTime;
  @JsonKey(name: 'started_time')
  DateTime? startedTime;
  @JsonKey(name: 'completed_time')
  DateTime? completedTime;
  String? priority;
  @JsonKey(name: 'total_peers')
  int? totalPeers;
  @JsonKey(name: 'connected_seeders')
  int? connectedSeeders;
  @JsonKey(name: 'connected_leechers')
  int? connectedLeechers;
  @JsonKey(name: 'connected_peers')
  int? connectedPeers;
  @JsonKey(name: 'seedelapsed')
  int? seedElapsed;
  @JsonKey(name: 'unzip_password')
  String? unzipPassword;
  @JsonKey(name: 'waiting_seconds')
  int? waitingSeconds;
  @JsonKey(name: 'total_pieces')
  int? totalPieces;

  TaskDetail(
      this.destination,
      this.uri,
      this.createTime,
      this.startedTime,
      this.completedTime,
      this.priority,
      this.totalPeers,
      this.connectedSeeders,
      this.connectedLeechers,
      this.connectedPeers,
      this.seedElapsed,
      this.unzipPassword,
      this.waitingSeconds,
      this.totalPieces);

  factory TaskDetail.fromJson(Map<String, dynamic> json) => _$TaskDetailFromJson(json);

  Map<String, dynamic> toJson() => _$TaskDetailToJson(this);
}

@JsonSerializable()
class TaskTransfer {
  @JsonKey(name: 'downloaded_pieces')
  int? downloadedPieces;
  @JsonKey(name: 'size_downloaded')
  int? sizeDownloaded;
  @JsonKey(name: 'size_uploaded')
  int? sizeUploaded;
  @JsonKey(name: 'speed_download')
  int? speedDownload;
  @JsonKey(name: 'speed_upload')
  int? speedUpload;

  TaskTransfer(this.downloadedPieces, this.sizeDownloaded, this.sizeUploaded, this.speedDownload, this.speedUpload);

  factory TaskTransfer.fromJson(Map<String, dynamic> json) => _$TaskTransferFromJson(json);

  Map<String, dynamic> toJson() => _$TaskTransferToJson(this);
}

@JsonSerializable()
class TaskFile {
  String? filename;
  int? index;
  int? size;
  @JsonKey(name: 'size_downloaded')
  int? sizeDownloaded;
  String? priority;
  bool? wanted;

  TaskFile(this.filename, this.index, this.size, this.sizeDownloaded, this.priority, this.wanted);

  factory TaskFile.fromJson(Map<String, dynamic> json) => _$TaskFileFromJson(json);

  Map<String, dynamic> toJson() => _$TaskFileToJson(this);
}

@JsonSerializable()
class TaskTracker {
  String? url;
  String? status;
  @JsonKey(name: 'update_timer')
  int? updateTimer;
  int? seeds;
  int? peers;

  TaskTracker(this.url, this.status, this.updateTimer, this.seeds, this.peers);

  factory TaskTracker.fromJson(Map<String, dynamic> json) => _$TaskTrackerFromJson(json);

  Map<String, dynamic> toJson() => _$TaskTrackerToJson(this);
}

@JsonSerializable()
class TaskPeer {
  String? address;
  String? agent;
  num? progress;
  @JsonKey(name: 'speed_download')
  int? speedDownload;
  @JsonKey(name: 'speed_upload')
  int? speedUpload;

  TaskPeer(this.address, this.agent, this.progress, this.speedDownload, this.speedUpload);

  factory TaskPeer.fromJson(Map<String, dynamic> json) => _$TaskPeerFromJson(json);

  Map<String, dynamic> toJson() => _$TaskPeerToJson(this);
}

@JsonSerializable()
class DownloadStationRSSSiteList {
  int total = 0;
  int offset = 0;
  List<Site> sites = [];

  DownloadStationRSSSiteList(this.total, this.offset, this.sites);

  factory DownloadStationRSSSiteList.fromJson(Map<String, dynamic> json) => _$DownloadStationRSSSiteListFromJson(json);

  Map<String, dynamic> toJson() => _$DownloadStationRSSSiteListToJson(this);
}

@JsonSerializable()
@DateTimeEpochConverter()
class Site {
  int? id;
  @JsonKey(name: 'is_updating')
  bool? isUpdating;
  String? title;
  String? url;
  @JsonKey(name: 'last_update')
  DateTime? lastUpdate;
  String? username;

  Site(this.id, this.isUpdating, this.title, this.url, this.lastUpdate, this.username);

  factory Site.fromJson(Map<String, dynamic> json) => _$SiteFromJson(json);

  Map<String, dynamic> toJson() => _$SiteToJson(this);
}

@JsonSerializable()
class DownloadStationRSSFeedList {
  int total = 0;
  int offset = 0;
  List<Feed> feeds = [];

  DownloadStationRSSFeedList(this.total, this.offset, this.feeds);

  factory DownloadStationRSSFeedList.fromJson(Map<String, dynamic> json) => _$DownloadStationRSSFeedListFromJson(json);

  Map<String, dynamic> toJson() => _$DownloadStationRSSFeedListToJson(this);
}

@JsonSerializable()
@DateTimeEpochConverter()
class Feed {
  String? title;
  String? size;
  DateTime? time;
  @JsonKey(name: 'download_uri')
  String? downloadUri;
  @JsonKey(name: 'external_link')
  String? externalLink;

  Feed(this.title, this.size, this.time, this.downloadUri, this.externalLink);

  factory Feed.fromJson(Map<String, dynamic> json) => _$FeedFromJson(json);

  Map<String, dynamic> toJson() => _$FeedToJson(this);
}
