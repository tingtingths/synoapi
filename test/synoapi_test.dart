import 'package:logging/logging.dart';
import 'package:synoapi/synoapi.dart' as api;
import 'package:test/test.dart';

import 'config.dart';

void main() {
  Logger.root.level = Level.FINEST;
  Logger.root.onRecord.listen((l) {
    print('${l.time} ${l.level} ${l.loggerName} | ${l.message}${l.error ?? ''}${l.stackTrace ?? ''}');
  });
  final l = Logger('unittest');

  // test setup
  var authOk;
  var cntx = api.APIContext(SYNO_HOST, port: SYNO_PORT);
  var queryApi = api.QueryAPI(cntx);
  var dsApi = api.DownloadStationAPI(cntx);
  setUp(() async {
    authOk = await cntx.authApp(api.Syno.DownloadStation.name, SYNO_USER, SYNO_USER_PASS);
  });

  test('Auth OK?', () {
    expect(authOk, equals(true));
  });

  group('Test Query API', () {
    test('Test API Info Query Result', () async {
      final resp = await queryApi.info.apiInfo();
      var apiQueryResult = resp.data;
      expect(apiQueryResult, isNotEmpty);
    });
  });

  group('Test Download Station API', () {
    test('Test Get Version', () async {
      final resp = await dsApi.info.getInfo();
      final versionStr = resp.data!.versionString;
      l.info('DS Version: $versionStr');
      expect(versionStr, isNotEmpty);
    });

    test('Test List Tasks', () async {
      final resp = await dsApi.task.list();
      final tasks = resp.data!.tasks;
      tasks.forEach((task) {
        l.info('Task: ${task.title}');
      });
      expect(tasks, isNotNull);
    });

    test('Test List RSS Sites', () async {
      final resp = await dsApi.rss.site.list();
      expect(resp, isNotNull);
      expect(resp.success, isTrue);
      resp.data!.sites.forEach((site) {
        l.info('${site.title} - ${site.url}');
      });
    });

    test('Test List RSS Feeds', () async {
      final resp = await dsApi.rss.feed.list('0');
      expect(resp, isNotNull);
    });
  });
}
