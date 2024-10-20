import 'dart:convert';

import 'package:http/http.dart' as httpClient;
import 'package:wallpaperapi_with/constant/app_constant.dart';

class ApiHelper {
  Future<dynamic> getApi(String url) async {
    var uri = Uri.parse(url);
    var responce = await httpClient
        .get(uri, headers: {"Authorization": AppConstant.pixcal_Api_Key});
    try {
      if (responce.statusCode == 200) {
        var resDecode = await jsonDecode(responce.body);
        return resDecode;
      }
    } catch (e) {
      print(e);
    }
  }
}
