import 'package:flutter/material.dart';
import 'package:flutter_shop/model/category_goods_list_model.dart';

class CategoryGoodsListProvider with ChangeNotifier {

  List<CategoryGoodsModel> goodsList = [];

  getCategoryGoodsList(List<CategoryGoodsModel> list) {
    goodsList = list;
    notifyListeners();
  }

  getMoreGoodsList(List<CategoryGoodsModel> list) {
    goodsList.addAll(list);
    notifyListeners();
    print('123');
  }
}