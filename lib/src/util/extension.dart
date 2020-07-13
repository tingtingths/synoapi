extension StringExtension on String {
  String capitalize() {
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  bool equalsIgnoreCase(String s) {
    return toLowerCase() == s.toLowerCase();
  }
}
