import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_shop/model/detail_model.dart';
import 'package:flutter_shop/service/service_method.dart';

class DetailInfoProvider with ChangeNotifier {
  DetailModel detail;

  getDetailInfo(String id) async {
    Map parameter = {'goodId': id};
    await request('getGoodDetailById', formData: parameter).then((value) {
      var data = json.decode(value.toString());
      detail = DetailModel.fromJson(data);
      notifyListeners();
    });
  }
}