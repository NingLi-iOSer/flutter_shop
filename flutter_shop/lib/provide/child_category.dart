import 'package:flutter/material.dart';
import 'package:flutter_shop/model/category_model.dart';

class ChildCategory with ChangeNotifier {
  List<BxMallSubDtoModel> childCategoryList = [];
  int childIndex = 0;
  String categoryId = '4';

  void getChildCategory(String categoryId, List<BxMallSubDtoModel> list) {
    childIndex = 0;
    categoryId = categoryId;

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