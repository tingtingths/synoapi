const String UNKNOWN = 'Unknown';

class Syno {
  static final name = 'SYNO';

  static _Api get API => _Api(name);

  static _Ds get DownloadStation => _Ds(name);
}

class _Api {
  final name = 'API';
  final String _base;

  _Api(this._base);

  String get Info => [_base, name, 'Info'].join('.');

  String get Auth => [_base, name, 'Auth'].join('.');
}

class _Ds {
  final name = 'DownloadStation';
  final String _base;

  _Ds(this._base);

  String get Info => [_base, name, 'Info'].join('.');

  String get Schedule => [_base, name, 'Schedule'].join('.');

  String get Task => [_base, name, 'Task'].join('.');

  String get Statistic => [_base, name, 'Statistic'].join('.');

  String get BTSearch => [_base, name, 'BTSearch'].join('.');

  _Rss get RSS => _Rss([_base, name].join('.'));
}

class _Rss {
  final name = 'RSS';
  final String _base;

  _Rss(this._base);

  String get Site => [_base, name, 'Site'].join('.');

  String get Feed => [_base, name, 'Feed'].join('.');
}
