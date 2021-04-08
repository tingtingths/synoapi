V? mapGet<K, V>(Map<K, dynamic>? dict, K key, {otherwise, Function(V value)? ifPresent}) {
  if (dict == null || !dict.containsKey(key)) {
    return otherwise;
  }

  if (ifPresent != null) {
    ifPresent(dict[key]);
  }

  return dict[key];
}
