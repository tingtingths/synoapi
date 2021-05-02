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
    json['version_string'] as String?,
    json['is_manager'] as bool?,
  );
}

Map<String, dynamic> _$DownloadStationInfoGetInfoToJson(
        DownloadStationInfoGetInfo instance) =>
    <String, dynamic>{
      'version': instance.version,
      'version_string': instance.versionString,
      'is_manager': instance.isManager,
    };

DownloadStationInfoGetConfig _$DownloadStationInfoGetConfigFromJson(
    Map<String, dynamic> json) {
  return DownloadStationInfoGetConfig(
    json['bt_max_download'] as int?,
    json['bt_max_upload'] as int?,
    json['emule_max_download'] as int?,
    json['emule_max_upload'] as int?,
    json['nzb_max_download'] as int?,
    json['http_max_download'] as int?,
    json['ftp_max_download'] as int?,
    json['emule_enabled'] as bool?,
    json['unzip_service_enabled'] as bool?,
    json['default_destination'] as String?,
    json['emule_default_destination'] as String?,
  );
}

Map<String, dynamic> _$DownloadStationInfoGetConfigToJson(
        DownloadStationInfoGetConfig instance) =>
    <String, dynamic>{
      'bt_max_download': instance.btMaxDownload,
      'bt_max_upload': instance.btMaxUpload,
      'emule_max_download': instance.emuleMaxDownload,
      'emule_max_upload': instance.emuleMaxUpload,
      'nzb_max_download': instance.nzbMaxDownload,
      'http_max_download': instance.httpMaxDownload,
      'ftp_max_download': instance.ftpMaxDownload,
      'emule_enabled': instance.emuleEnabled,
      'unzip_service_enabled': instance.unzipServiceEnabled,
      'default_destination': instance.defaultDestination,
      'emule_default_destination': instance.emuleDefaultDestination,
    };

DownloadStationScheduleGetConfig _$DownloadStationScheduleGetConfigFromJson(
    Map<String, dynamic> json) {
  return DownloadStationScheduleGetConfig(
    json['enabled'] as bool?,
    json['emule_enabled'] as bool?,
  );
}

Map<String, dynamic> _$DownloadStationScheduleGetConfigToJson(
        DownloadStationScheduleGetConfig instance) =>
    <String, dynamic>{
      'enabled': instance.enabled,
      'emule_enabled': instance.emuleEnabled,
    };

DownloadStationStatisticGetInfo _$DownloadStationStatisticGetInfoFromJson(
    Map<String, dynamic> json) {
  return DownloadStationStatisticGetInfo(
    json['speed_download'] as int?,
    json['speed_upload'] as int?,
    json['emule_speed_download'] as int?,
    json['emule_speed_upload'] as int?,
  );
}

Map<String, dynamic> _$DownloadStationStatisticGetInfoToJson(
        DownloadStationStatisticGetInfo instance) =>
    <String, dynamic>{
      'speed_download': instance.speedDownload,
      'speed_upload': instance.speedUpload,
      'emule_speed_download': instance.emuleSpeedDownload,
      'emule_speed_upload': instance.emuleSpeedUpload,
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
    json['status_extra'] == null
        ? null
        : StatusExtra.fromJson(json['status_extra'] as Map<String, dynamic>),
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
      'status_extra': instance.statusExtra,
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
    json['error_detail'] as String?,
    json['unzip_progress'] as int?,
  );
}

Map<String, dynamic> _$StatusExtraToJson(StatusExtra instance) =>
    <String, dynamic>{
      'error_detail': instance.errorDetail,
      'unzip_progress': instance.unzipProgress,
    };

TaskDetail _$TaskDetailFromJson(Map<String, dynamic> json) {
  return TaskDetail(
    json['destination'] as String?,
    json['uri'] as String?,
    const DateTimeEpochConverter().fromJson(json['create_time'] as int?),
    const DateTimeEpochConverter().fromJson(json['started_time'] as int?),
    const DateTimeEpochConverter().fromJson(json['completed_time'] as int?),
    json['priority'] as String?,
    json['total_peers'] as int?,
    json['connected_seeders'] as int?,
    json['connected_leechers'] as int?,
    json['connected_peers'] as int?,
    json['seedelapsed'] as int?,
    json['unzip_password'] as String?,
    json['waiting_seconds'] as int?,
    json['total_pieces'] as int?,
  );
}

Map<String, dynamic> _$TaskDetailToJson(TaskDetail instance) =>
    <String, dynamic>{
      'destination': instance.destination,
      'uri': instance.uri,
      'create_time': const DateTimeEpochConverter().toJson(instance.createTime),
      'started_time':
          const DateTimeEpochConverter().toJson(instance.startedTime),
      'completed_time':
          const DateTimeEpochConverter().toJson(instance.completedTime),
      'priority': instance.priority,
      'total_peers': instance.totalPeers,
      'connected_seeders': instance.connectedSeeders,
      'connected_leechers': instance.connectedLeechers,
      'connected_peers': instance.connectedPeers,
      'seedelapsed': instance.seedElapsed,
      'unzip_password': instance.unzipPassword,
      'waiting_seconds': instance.waitingSeconds,
      'total_pieces': instance.totalPieces,
    };

TaskTransfer _$TaskTransferFromJson(Map<String, dynamic> json) {
  return TaskTransfer(
    json['downloaded_pieces'] as int?,
    json['size_downloaded'] as int?,
    json['size_uploaded'] as int?,
    json['speed_download'] as int?,
    json['speed_upload'] as int?,
  );
}

Map<String, dynamic> _$TaskTransferToJson(TaskTransfer instance) =>
    <String, dynamic>{
      'downloaded_pieces': instance.downloadedPieces,
      'size_downloaded': instance.sizeDownloaded,
      'size_uploaded': instance.sizeUploaded,
      'speed_download': instance.speedDownload,
      'speed_upload': instance.speedUpload,
    };

TaskFile _$TaskFileFromJson(Map<String, dynamic> json) {
  return TaskFile(
    json['filename'] as String?,
    json['index'] as int?,
    json['size'] as int?,
    json['size_downloaded'] as int?,
    json['priority'] as String?,
    json['wanted'] as bool?,
  );
}

Map<String, dynamic> _$TaskFileToJson(TaskFile instance) => <String, dynamic>{
      'filename': instance.filename,
      'index': instance.index,
      'size': instance.size,
      'size_downloaded': instance.sizeDownloaded,
      'priority': instance.priority,
      'wanted': instance.wanted,
    };

TaskTracker _$TaskTrackerFromJson(Map<String, dynamic> json) {
  return TaskTracker(
    json['url'] as String?,
    json['status'] as String?,
    json['update_timer'] as int?,
    json['seeds'] as int?,
    json['peers'] as int?,
  );
}

Map<String, dynamic> _$TaskTrackerToJson(TaskTracker instance) =>
    <String, dynamic>{
      'url': instance.url,
      'status': instance.status,
      'update_timer': instance.updateTimer,
      'seeds': instance.seeds,
      'peers': instance.peers,
    };

TaskPeer _$TaskPeerFromJson(Map<String, dynamic> json) {
  return TaskPeer(
    json['address'] as String?,
    json['agent'] as String?,
    json['progress'] as num?,
    json['speed_download'] as int?,
    json['speed_upload'] as int?,
  );
}

Map<String, dynamic> _$TaskPeerToJson(TaskPeer instance) => <String, dynamic>{
      'address': instance.address,
      'agent': instance.agent,
      'progress': instance.progress,
      'speed_download': instance.speedDownload,
      'speed_upload': instance.speedUpload,
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
    const DateTimeEpochConverter().fromJson(json['last_update'] as int?),
    json['username'] as String?,
  );
}

Map<String, dynamic> _$SiteToJson(Site instance) => <String, dynamic>{
      'id': instance.id,
      'is_updating': instance.isUpdating,
      'title': instance.title,
      'url': instance.url,
      'last_update': const DateTimeEpochConverter().toJson(instance.lastUpdate),
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
    const DateTimeEpochConverter().fromJson(json['time'] as int?),
    json['download_uri'] as String?,
    json['external_link'] as String?,
  );
}

Map<String, dynamic> _$FeedToJson(Feed instance) => <String, dynamic>{
      'title': instance.title,
      'size': instance.size,
      'time': const DateTimeEpochConverter().toJson(instance.time),
      'download_uri': instance.downloadUri,
      'external_link': instance.externalLink,
    };
