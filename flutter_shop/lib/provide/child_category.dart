import 'package:flutter/material.dart';
import 'package:flutter_shop/model/category_model.dart';

class ChildCategory with ChangeNotifier {
  List<BxMallSubDtoModel> childCategoryList = [];
  int childIndex = 0;

  void getChildCategory(List<BxMallSubDtoModel> list) {
    childIndex = 0;

    BxMallSubDtoModel all = BxMallSubDtoModel();
    all.mallSubName = '全部';
    all.mallSubId = '';
    all.mallCategoryId = '';
    all.comments = '';
    childCategoryList = [all];
    childCategoryList.addAll(list);
    notifyListeners();
  }

  void changeChildIndex(int index) {
    childIndex = index;
    notifyListeners();
  }
}