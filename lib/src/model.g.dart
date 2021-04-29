// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

APIInfoQuery _$APIInfoQueryFromJson(Map<String, dynamic> json) {
  return APIInfoQuery(
    json['key'] as String?,
    json['path'] as String?,
    json['minVersion'] as int?,
    json['maxVersion'] as int?,
  );
}

Map<String, dynamic> _$APIInfoQueryToJson(APIInfoQuery instance) =>
    <String, dynamic>{
      'key': instance.key,
      'path': instance.path,
      'minVersion': instance.minVersion,
      'maxVersion': instance.maxVersion,
    };

DownloadStationInfoGetInfo _$DownloadStationInfoGetInfoFromJson(
    Map<String, dynamic> json) {
  return DownloadStationInfoGetInfo(
    json['version'] as int?,
    json['versionString'] as String?,
    json['isManager'] as bool?,
  );
}

Map<String, dynamic> _$DownloadStationInfoGetInfoToJson(
        DownloadStationInfoGetInfo instance) =>
    <String, dynamic>{
      'version': instance.version,
      'versionString': instance.versionString,
      'isManager': instance.isManager,
    };

DownloadStationInfoGetConfig _$DownloadStationInfoGetConfigFromJson(
    Map<String, dynamic> json) {
  return DownloadStationInfoGetConfig(
    json['btMaxDownload'] as int?,
    json['btMaxUpload'] as int?,
    json['emuleMaxDownload'] as int?,
    json['emuleMaxUpload'] as int?,
    json['nzbMaxDownload'] as int?,
    json['httpMaxDownload'] as int?,
    json['ftpMaxDownload'] as int?,
    json['emuleEnabled'] as bool?,
    json['unzipServiceEnabled'] as bool?,
    json['defaultDestination'] as String?,
    json['emuleDefaultDestination'] as String?,
  );
}

Map<String, dynamic> _$DownloadStationInfoGetConfigToJson(
        DownloadStationInfoGetConfig instance) =>
    <String, dynamic>{
      'btMaxDownload': instance.btMaxDownload,
      'btMaxUpload': instance.btMaxUpload,
      'emuleMaxDownload': instance.emuleMaxDownload,
      'emuleMaxUpload': instance.emuleMaxUpload,
      'nzbMaxDownload': instance.nzbMaxDownload,
      'httpMaxDownload': instance.httpMaxDownload,
      'ftpMaxDownload': instance.ftpMaxDownload,
      'emuleEnabled': instance.emuleEnabled,
      'unzipServiceEnabled': instance.unzipServiceEnabled,
      'defaultDestination': instance.defaultDestination,
      'emuleDefaultDestination': instance.emuleDefaultDestination,
    };

DownloadStationScheduleGetConfig _$DownloadStationScheduleGetConfigFromJson(
    Map<String, dynamic> json) {
  return DownloadStationScheduleGetConfig(
    json['enabled'] as bool?,
    json['emuleEnabled'] as bool?,
  );
}

Map<String, dynamic> _$DownloadStationScheduleGetConfigToJson(
        DownloadStationScheduleGetConfig instance) =>
    <String, dynamic>{
      'enabled': instance.enabled,
      'emuleEnabled': instance.emuleEnabled,
    };

DownloadStationStatisticGetInfo _$DownloadStationStatisticGetInfoFromJson(
    Map<String, dynamic> json) {
  return DownloadStationStatisticGetInfo(
    json['speedDownload'] as int?,
    json['speedUpload'] as int?,
    json['emuleSpeedDownload'] as int?,
    json['emuleSpeedUpload'] as int?,
  );
}

Map<String, dynamic> _$DownloadStationStatisticGetInfoToJson(
        DownloadStationStatisticGetInfo instance) =>
    <String, dynamic>{
      'speedDownload': instance.speedDownload,
      'speedUpload': instance.speedUpload,
      'emuleSpeedDownload': instance.emuleSpeedDownload,
      'emuleSpeedUpload': instance.emuleSpeedUpload,
    };

_DownloadStationTaskActionResponse _$_DownloadStationTaskActionResponseFromJson(
    Map<String, dynamic> json) {
  return _DownloadStationTaskActionResponse(
    json['id'] as String?,
    json['error'] as int?,
  );
}

Map<String, dynamic> _$_DownloadStationTaskActionResponseToJson(
        _DownloadStationTaskActionResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'error': instance.error,
    };

ListTaskInfo _$ListTaskInfoFromJson(Map<String, dynamic> json) {
  return ListTaskInfo(
    json['total'] as int,
    json['offset'] as int,
    (json['tasks'] as List<dynamic>)
        .map((e) => Task.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ListTaskInfoToJson(ListTaskInfo instance) =>
    <String, dynamic>{
      'total': instance.total,
      'offset': instance.offset,
      'tasks': instance.tasks,
    };

Task _$TaskFromJson(Map<String, dynamic> json) {
  return Task(
    json['id'] as String?,
    json['type'] as String?,
    json['username'] as String?,
    json['title'] as String?,
    json['size'] as int?,
    _$enumDecodeNullable(_$TaskStatusEnumMap, json['status']),
    json['statusExtra'] == null
        ? null
        : StatusExtra.fromJson(json['statusExtra'] as Map<String, dynamic>),
    json['additional'] == null
        ? null
        : Additional.fromJson(json['additional'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'username': instance.username,
      'title': instance.title,
      'size': instance.size,
      'statusExtra': instance.statusExtra,
      'additional': instance.additional,
      'status': _$TaskStatusEnumMap[instance.status],
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

K? _$enumDecodeNullable<K, V>(
  Map<K, V> enumValues,
  dynamic source, {
  K? unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<K, V>(enumValues, source, unknownValue: unknownValue);
}

const _$TaskStatusEnumMap = {
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
};

Additional _$AdditionalFromJson(Map<String, dynamic> json) {
  return Additional(
    json['detail'] == null
        ? null
        : TaskDetail.fromJson(json['detail'] as Map<String, dynamic>),
    json['transfer'] == null
        ? null
        : TaskTransfer.fromJson(json['transfer'] as Map<String, dynamic>),
    (json['file'] as List<dynamic>?)
        ?.map((e) => TaskFile.fromJson(e as Map<String, dynamic>))
        .toList(),
    (json['tracker'] as List<dynamic>?)
        ?.map((e) => TaskTracker.fromJson(e as Map<String, dynamic>))
        .toList(),
    (json['peer'] as List<dynamic>?)
        ?.map((e) => TaskPeer.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$AdditionalToJson(Additional instance) =>
    <String, dynamic>{
      'detail': instance.detail,
      'transfer': instance.transfer,
      'file': instance.file,
      'tracker': instance.tracker,
      'peer': instance.peer,
    };

StatusExtra _$StatusExtraFromJson(Map<String, dynamic> json) {
  return StatusExtra(
    json['errorDetail'] as String?,
    json['unzipProgress'] as int?,
  );
}

Map<String, dynamic> _$StatusExtraToJson(StatusExtra instance) =>
    <String, dynamic>{
      'errorDetail': instance.errorDetail,
      'unzipProgress': instance.unzipProgress,
    };

TaskDetail _$TaskDetailFromJson(Map<String, dynamic> json) {
  return TaskDetail(
    json['destination'] as String?,
    json['uri'] as String?,
    json['createTime'] == null
        ? null
        : DateTime.parse(json['createTime'] as String),
    json['startedTime'] == null
        ? null
        : DateTime.parse(json['startedTime'] as String),
    json['completedTime'] == null
        ? null
        : DateTime.parse(json['completedTime'] as String),
    json['priority'] as String?,
    json['totalPeers'] as int?,
    json['connectedSeeders'] as int?,
    json['connectedLeechers'] as int?,
    json['connectedPeers'] as int?,
    json['seedElapsed'] as int?,
    json['unzipPassword'] as String?,
    json['waitingSeconds'] as int?,
    json['totalPieces'] as int?,
  );
}

Map<String, dynamic> _$TaskDetailToJson(TaskDetail instance) =>
    <String, dynamic>{
      'destination': instance.destination,
      'uri': instance.uri,
      'createTime': instance.createTime?.toIso8601String(),
      'startedTime': instance.startedTime?.toIso8601String(),
      'completedTime': instance.completedTime?.toIso8601String(),
      'priority': instance.priority,
      'totalPeers': instance.totalPeers,
      'connectedSeeders': instance.connectedSeeders,
      'connectedLeechers': instance.connectedLeechers,
      'connectedPeers': instance.connectedPeers,
      'seedElapsed': instance.seedElapsed,
      'unzipPassword': instance.unzipPassword,
      'waitingSeconds': instance.waitingSeconds,
      'totalPieces': instance.totalPieces,
    };

TaskTransfer _$TaskTransferFromJson(Map<String, dynamic> json) {
  return TaskTransfer(
    json['downloadedPieces'] as int?,
    json['sizeDownloaded'] as int?,
    json['sizeUploaded'] as int?,
    json['speedDownload'] as int?,
    json['speedUpload'] as int?,
  );
}

Map<String, dynamic> _$TaskTransferToJson(TaskTransfer instance) =>
    <String, dynamic>{
      'downloadedPieces': instance.downloadedPieces,
      'sizeDownloaded': instance.sizeDownloaded,
      'sizeUploaded': instance.sizeUploaded,
      'speedDownload': instance.speedDownload,
      'speedUpload': instance.speedUpload,
    };

TaskFile _$TaskFileFromJson(Map<String, dynamic> json) {
  return TaskFile(
    json['filename'] as String?,
    json['index'] as int?,
    json['size'] as int?,
    json['sizeDownloaded'] as int?,
    json['priority'] as String?,
    json['wanted'] as bool?,
  );
}

Map<String, dynamic> _$TaskFileToJson(TaskFile instance) => <String, dynamic>{
      'filename': instance.filename,
      'index': instance.index,
      'size': instance.size,
      'sizeDownloaded': instance.sizeDownloaded,
      'priority': instance.priority,
      'wanted': instance.wanted,
    };

TaskTracker _$TaskTrackerFromJson(Map<String, dynamic> json) {
  return TaskTracker(
    json['url'] as String?,
    json['status'] as String?,
    json['updateTimer'] as int?,
    json['seeds'] as int?,
    json['peers'] as int?,
  );
}

Map<String, dynamic> _$TaskTrackerToJson(TaskTracker instance) =>
    <String, dynamic>{
      'url': instance.url,
      'status': instance.status,
      'updateTimer': instance.updateTimer,
      'seeds': instance.seeds,
      'peers': instance.peers,
    };

TaskPeer _$TaskPeerFromJson(Map<String, dynamic> json) {
  return TaskPeer(
    json['address'] as String?,
    json['agent'] as String?,
    json['progress'] as num?,
    json['speedDownload'] as int?,
    json['speedUpload'] as int?,
  );
}

Map<String, dynamic> _$TaskPeerToJson(TaskPeer instance) => <String, dynamic>{
      'address': instance.address,
      'agent': instance.agent,
      'progress': instance.progress,
      'speedDownload': instance.speedDownload,
      'speedUpload': instance.speedUpload,
    };

DownloadStationRSSSiteList _$DownloadStationRSSSiteListFromJson(
    Map<String, dynamic> json) {
  return DownloadStationRSSSiteList(
    json['total'] as int,
    json['offset'] as int,
    (json['sites'] as List<dynamic>)
        .map((e) => Site.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$DownloadStationRSSSiteListToJson(
        DownloadStationRSSSiteList instance) =>
    <String, dynamic>{
      'total': instance.total,
      'offset': instance.offset,
      'sites': instance.sites,
    };

Site _$SiteFromJson(Map<String, dynamic> json) {
  return Site(
    json['id'] as int?,
    json['is_updating'] as bool?,
    json['title'] as String?,
    json['url'] as String?,
    json['lastUpdate'] == null
        ? null
        : DateTime.parse(json['lastUpdate'] as String),
    json['username'] as String?,
  );
}

Map<String, dynamic> _$SiteToJson(Site instance) => <String, dynamic>{
      'id': instance.id,
      'is_updating': instance.is_updating,
      'title': instance.title,
      'url': instance.url,
      'lastUpdate': instance.lastUpdate?.toIso8601String(),
      'username': instance.username,
    };

DownloadStationRSSFeedList _$DownloadStationRSSFeedListFromJson(
    Map<String, dynamic> json) {
  return DownloadStationRSSFeedList(
    json['total'] as int,
    json['offset'] as int,
    (json['feeds'] as List<dynamic>)
        .map((e) => Feed.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$DownloadStationRSSFeedListToJson(
        DownloadStationRSSFeedList instance) =>
    <String, dynamic>{
      'total': instance.total,
      'offset': instance.offset,
      'feeds': instance.feeds,
    };

Feed _$FeedFromJson(Map<String, dynamic> json) {
  return Feed(
    json['title'] as String?,
    json['size'] as String?,
    json['time'] == null ? null : DateTime.parse(json['time'] as String),
    json['downloadUri'] as String?,
    json['externalLink'] as String?,
  );
}

Map<String, dynamic> _$FeedToJson(Feed instance) => <String, dynamic>{
      'title': instance.title,
      'size': instance.size,
      'time': instance.time?.toIso8601String(),
      'downloadUri': instance.downloadUri,
      'externalLink': instance.externalLink,
    };
