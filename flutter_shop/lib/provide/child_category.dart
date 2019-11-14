import 'package:flutter/material.dart';
import 'package:flutter_shop/model/category_model.dart';

class ChildCategory with ChangeNotifier {
  List<BxMallSubDtoModel> childCategoryList = [];

  void getChildCategory(List<BxMallSubDtoModel> list) {
    BxMallSubDtoModel all = BxMallSubDtoModel();
    all.mallSubName = '全部';
    all.mallSubId = '';
    all.mallCategoryId = '';
    all.comments = '';
    childCategoryList = [all];
    childCategoryList.addAll(list);
    notifyListeners();
  }
}