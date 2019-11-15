import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_shop/model/detail_model.dart';
import 'package:flutter_shop/service/service_method.dart';

class DetailInfoProvider with ChangeNotifier {
  DetailModel detail;

  getDetailInfo(String id) async {
    print('商品 Id: $id');
    Map parameter = {'goodId': id};
    await request('getGoodDetailById', formData: parameter).then((value) {
      var data = json.decode(value.toString());
      print(data);
      DetailModel model = DetailModel.fromJson(data['data']);
      detail = model;
      notifyListeners();
    });
  }
}