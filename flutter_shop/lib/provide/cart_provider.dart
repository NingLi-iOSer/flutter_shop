
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvider with ChangeNotifier {
  String cartString = '[]';

  save(goodsId, goodsName, count, price, images) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    cartString = preferences.getString('cartInfo');
    var temp = (cartString == null) ? [] : json.decode(cartString);
    List<Map> cartList = (temp as List).cast();

    bool isHave = false;
    int index = 0;
    cartList.forEach((item){
      if (item['goodsId'] == goodsId) {
        cartList[index]['count'] = item['count'] + 1;
        isHave = true;
      }
      index++;
    });

    if (!isHave) {
      cartList.add({
        'goodsId': goodsId,
        'goodsName': goodsName,
        'count': count,
        'price': price,
        'images': images
      });
    }

    cartString = json.encode(cartList);
    preferences.setString('cartInfo', cartString);
    notifyListeners();

    print(cartString);
  }

  clear() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove('cartInfo');
    cartString = '[]';
    notifyListeners();

    print('清空完成');
  }
}