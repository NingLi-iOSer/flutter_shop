import 'package:dio/dio.dart';
import 'dart:async';

import 'package:flutter_shop/config/service_url.dart';

Future getHomePageContent() async {
  try {
    print("Load Home Page Content...");
    Dio dio = new Dio();
    dio.options.contentType = 'application/x-www-form-urlencoded';
    var parameters = {'lon': '115.12345', 'lat': '39.22112'};
    Response response = await dio.post(servicePath['homePageContent'], data: parameters);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      return Exception('后端接口出现错误');
    }
  } catch (e) {
    throw('Error: $e');
  }
}