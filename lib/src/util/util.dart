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

enum TimestampUnit {
  SECOND, MILLISECOND, MICROSECOND
}

extension TimestampUnitExt on TimestampUnit {
  int toMilliseconds(int num) {
    switch (this) {
      case TimestampUnit.SECOND:
        return num * 1000;
      case TimestampUnit.MILLISECOND:
        return num * 1;
      case TimestampUnit.MICROSECOND:
        return (num / 1000).round();
      default:
        return num;
    }
  }
}

class DateTimeEpochConverter implements JsonConverter<DateTime?, int?> {

  final TimestampUnit unit;

  const DateTimeEpochConverter({this.unit = TimestampUnit.SECOND});

  @override
  DateTime? fromJson(int? json) {
    return json == null || json == 0 ? null : DateTime.fromMillisecondsSinceEpoch(unit.toMilliseconds(json));
  }

  @override
  int? toJson(DateTime? object) {
    return object == null ? null : object.millisecondsSinceEpoch;
  }
}
