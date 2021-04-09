V? mapGet<K, V>(Map<K, dynamic>? dict, K key, {otherwise, Function? mapper, Function(V value)? ifPresent}) {
  if (dict == null || !dict.containsKey(key) || dict[key] == null) {
    return otherwise;
  }

  if (ifPresent != null) {
    ifPresent(dict[key]);
  }

  if (mapper != null) return mapper(dict[key]);
  return dict[key];
}
