import 'dart:convert';

import '../context.dart';
import '../query.dart';
import 'model.dart';


class QueryAPI extends QueryAPIRaw {
  QueryAPI(APIContext cntx) : super(cntx);

  Future<APIResponse<Map<String, APIInfoQuery>>> apiInfo({int version, String query = 'all'}) async {
    return super.apiInfoRaw(version: version).then((resp) {
      return APIResponse<Map<String, APIInfoQuery>>.fromJson(jsonDecode(resp.data), (data) {
        var result = <String, APIInfoQuery>{};
        data.forEach((key, value) {
          result[key] = APIInfoQuery.fromJson(value);
        });
        return result;
      });
    });
  }
}
