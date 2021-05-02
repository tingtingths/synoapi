import 'package:json_annotation/json_annotation.dart';

V? mapGet<K, V>(Map<K, dynamic>? dict, K key, {otherwise, Function? mapper, Function(V value)? ifPresent}) {
  if (dict == null || !dict.containsKey(key) || dict[key] == null) {
    return otherwise;
  }

  if (ifPresent != null) {
    ifPresent(dict[key]!);
  }

  if (mapper != null) return mapper(dict[key]);
  return dict[key];
}

class DateTimeEpochConverter implements JsonConverter<DateTime?, int?> {
  const DateTimeEpochConverter();

  @override
  DateTime? fromJson(int? json) {
    return json == null ? null : DateTime.fromMillisecondsSinceEpoch(json);
  }

  @override
  int? toJson(DateTime? object) {
    return object == null ? null : object.millisecondsSinceEpoch;
  }
}
