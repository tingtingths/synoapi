import 'package:logging/logging.dart';
import 'package:synoapi/synoapi.dart' as api;
import 'package:test/test.dart';

import 'config.dart';

void main() {
  Logger.root.level = Level.INFO;
  Logger.root.onRecord.listen((l) {
    print('${l.time} ${l.level} ${l.loggerName} | ${l.message}${l.error ?? ''}${l.stackTrace ?? ''}');
  });
  final l = Logger('unittest');

  // test setup
  var authOk;
  var cntx = api.APIContext(SYNO_HOST, port: SYNO_PORT);
  var queryApi = api.QueryAPI(cntx);
  var queryApi2 = api.QueryAPI(cntx);
  var dsApi = api.DownloadStationAPI(cntx);
  setUp(() async {
    authOk = await cntx.authApp(api.Syno.DownloadStation.name, SYNO_USER, SYNO_USER_PASS);
  });

  test('Auth OK?', () {
    expect(authOk, equals(true));
  });

  group('Test Query API', () {
    test('Test Query Result', () {
      queryApi.info.apiInfo().then((resp) {
        var apiQueryResult = resp.data;
        expect(apiQueryResult, isNotEmpty);
      });
    });
  });

  group('Test Download Station API', () {
    test('Test Get Version', () {
      dsApi.info.getInfo().then((resp) {
        final versionStr = resp.data!.versionString;
        l.info('DS Version: $versionStr');
        expect(versionStr, isNotEmpty);
      });
    });

    test('Test Get Tasks', () {
      dsApi.task.list().then((resp) {
        final tasks = resp.data!.tasks;
        tasks.forEach((task) {
          l.info('Task: ${task.title}');
        });
        expect(tasks, isNotNull);
      });
    });
  });
}
