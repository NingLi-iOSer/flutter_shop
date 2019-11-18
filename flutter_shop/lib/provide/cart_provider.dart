
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_shop/model/cart_info_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvider with ChangeNotifier {
  List<CartInfoModel> cartList = [];

  save(goodsId, goodsName, count, price, oriPrice, images) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String cartString = preferences.getString('cartInfo');
    var temp = (cartString == null) ? [] : json.decode(cartString);
    List<Map> tempList = (temp as List).cast();

    bool isHave = false;
    int index = 0;
    tempList.forEach((item){
      if (item['goodsId'] == goodsId) {
        tempList[index]['count'] = item['count'] + 1;
        cartList[index].count++;
        isHave = true;
      }
      index++;
    });

    if (!isHave) {
      Map<String, dynamic> newInfo = {
        'goodsId': goodsId,
        'goodsName': goodsName,
        'count': count,
        'price': price,
        'oriPrice': oriPrice,
        'images': images
      };
      tempList.add(newInfo);
      cartList.add(CartInfoModel.fromJson(newInfo));
    }

    cartString = json.encode(tempList);
    preferences.setString('cartInfo', cartString);
    notifyListeners();
  }

  clear() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove('cartInfo');
    cartList = [];
    notifyListeners();

    print('清空完成');
  }

  getCartInfo() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String cartString = preferences.getString('cartInfo');
    var temp = (cartString == null) ? [] : json.decode(cartString);
    List<Map> tempList = (temp as List).cast();
    if (!tempList.isEmpty) {
      cartList = tempList.map((item) {
        return CartInfoModel.fromJson(item);
      }).toList();
    }
  }
}