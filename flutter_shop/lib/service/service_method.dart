import 'package:dio/dio.dart';
import 'dart:async';
import 'package:flutter_shop/config/service_url.dart';

Future request(url, {formData}) async {
  try {
    print("Load Content...");
    Dio dio = new Dio();
    dio.options.contentType = 'application/x-www-form-urlencoded';
    Response response = await dio.post(servicePath[url], data: formData);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      return Exception('后端接口出现错误');
    }
  } catch (e) {
    throw('Error: $e');
  }
}