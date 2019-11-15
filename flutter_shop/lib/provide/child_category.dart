import 'package:flutter/material.dart';
import 'package:flutter_shop/model/category_model.dart';

class ChildCategory with ChangeNotifier {
  List<BxMallSubDtoModel> childCategoryList = [];
  int childIndex = 0;
  String categoryId = '4';
  String subId = '';
  int page = 1;
  String noMoreText = '';

  void getChildCategory(String id, List<BxMallSubDtoModel> list) {
    // 切换大类清除数据
    childIndex = 0;
    categoryId = id;
    subId = '';
    page = 1;
    noMoreText = '';

    BxMallSubDtoModel all = BxMallSubDtoModel();
    all.mallSubName = '全部';
    all.mallSubId = '';
    all.mallCategoryId = '';
    all.comments = '';
    childCategoryList = [all];
    childCategoryList.addAll(list);
    notifyListeners();
  }

  void changeChildIndex(int index, String categorySubId) {
    childIndex = index;
    subId = categorySubId;
    noMoreText = '';
    page = 1;
    notifyListeners();
  }

  void increacePage() {
    page++;
  }

  void changeNoMore(String text) {
    noMoreText = text;
    notifyListeners();
  }
}
