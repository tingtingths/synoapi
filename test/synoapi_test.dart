import 'dart:io';

import 'package:synoapi/synoapi.dart' as api;

void main() async {
  // build context
  var cntx = api.APIContext('localhost', port: 50443);
  var authOk = await cntx.authApp(api.Syno.DownloadStation.name, 'ds_api', 'w&pWSMi\$PRNP4EDP7M5LcJl8');
  if (!authOk) exit(1);

  // init api
  var queryApi = api.QueryAPI(cntx);
  var queryApi2 = api.QueryAPI(cntx);
  var dsApi = api.DownloadStationAPI(cntx);

  // test get api info
  await queryApi.info.apiInfo().then((resp) {
    var apiQueryResult = resp.data;
    print(apiQueryResult);
  });
}
