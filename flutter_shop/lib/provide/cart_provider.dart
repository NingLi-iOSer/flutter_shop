
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_shop/model/cart_info_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvider with ChangeNotifier {
  List<CartInfoModel> cartList = [];
  // 选中的价格
  double selectedPrice = 0;
  // 选中的数量
  int selectedCount = 0;
  // 全选标记
  bool isSelectedAll = false;
  // 总数量
  int totalCount = 0;

  // 加入购物车
  save(goodsId, goodsName, count, price, oriPrice, images) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String cartString = preferences.getString('cartInfo');
    var temp = (cartString == null) ? [] : json.decode(cartString);
    List<Map> tempList = (temp as List).cast();

    selectedPrice = 0;
    selectedCount = 0;
    totalCount = 0;

    bool isHave = false;
    int index = 0;
    tempList.forEach((item){
      if (item['goodsId'] == goodsId) {
        tempList[index]['count'] = item['count'] + 1;
        cartList[index].count++;
        isHave = true;
      }
      if (item['isSelected']) {
        selectedPrice += (cartList[index].count * price);
        selectedCount++;
      }
      totalCount += cartList[index].count;
      index++;
    });

    if (!isHave) {
      Map<String, dynamic> newInfo = {
        'goodsId': goodsId,
        'goodsName': goodsName,
        'count': count,
        'price': price,
        'oriPrice': oriPrice,
        'images': images,
        'isSelected': true
      };
      tempList.add(newInfo);
      cartList.add(CartInfoModel.fromJson(newInfo));

      selectedPrice += (count * price);
      selectedCount++;
      totalCount++;
    }

    cartString = json.encode(tempList);
    preferences.setString('cartInfo', cartString);
    notifyListeners();
  }

  // 清空购物车
  clear() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove('cartInfo');
    cartList = [];
    notifyListeners();

    print('清空完成');
  }

  // 获取购物车商品信息
  getCartInfo() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String cartString = preferences.getString('cartInfo');
    var temp = (cartString == null) ? [] : json.decode(cartString);
    List<Map> tempList = (temp as List).cast();

    double tempTotalPrice = 0;
    int tempTotalCount = 0;
    totalCount = 0;
    if (tempList.isNotEmpty) {
      cartList = tempList.map((item) {
        if (item['isSelected'] == true) {
          tempTotalCount++;
          tempTotalPrice += (item['price'] * item['count']);
        }
        totalCount += item['count'];
        return CartInfoModel.fromJson(item);
      }).toList();
      isSelectedAll = (selectedCount == tempList.length);
    } else {
      isSelectedAll = false;
      cartList = [];
      totalCount = 0;
    }

    selectedPrice = tempTotalPrice;
    selectedCount = tempTotalCount;

    notifyListeners();
  }

  // 删除购物车商品
  deleteCartGoods(String goodsId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String cartString = preferences.getString('cartInfo');
    var temp = (cartString == null) ? [] : json.decode(cartString);
    List<Map> tempList = (temp as List).cast();

    int deleteIndex = -1;
    for (var i = 0; i < tempList.length; i++) {
      Map<String, dynamic> item = tempList[i];
      if (item['goodsId'] == goodsId) {
        deleteIndex = i;
        break;
      }
    }

    if (deleteIndex != -1) {
      cartList.removeAt(deleteIndex);
      tempList.removeAt(deleteIndex);
      cartString = json.encode(tempList);
      preferences.setString('cartInfo', cartString);
      notifyListeners();
    }
  }

  // 修改购物车商品数量
  modifyCartGoodsCount(String goodsId, int count) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String cartString = preferences.getString('cartInfo');
    var temp = (cartString == null) ? [] : json.decode(cartString);
    List<Map> tempList = (temp as List).cast();

    int index = 0;
    for (var i = 0; i < tempList.length; i++) {
      Map<String, dynamic> item = tempList[i];
      if (item['goodsId'] == goodsId) {
        index = i;
        tempList[index]['count'] = count;
        cartList[index].count = count;
        cartString = json.encode(tempList);
        preferences.setString('cartInfo', cartString);
        await getCartInfo();
        break;
      }
    }
  }

  // 修改购物车商品选中状态
  modifyCartGoodsSelectedStatus(String goodsId, bool isSelected) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String cartString = preferences.getString('cartInfo');
    var temp = (cartString == null) ? [] : json.decode(cartString);
    List<Map> tempList = (temp as List).cast();

    int index = 0;
    for (var i = 0; i < tempList.length; i++) {
      Map<String, dynamic> item = tempList[i];
      if (item['goodsId'] == goodsId) {
        index = i;
        tempList[index]['isSelected'] = isSelected;
        cartList[index].isSelected = isSelected;
        cartString = json.encode(tempList);
        preferences.setString('cartInfo', cartString);
        await getCartInfo();
        break;
      }
    }
  }

  // 修改全选状态
  modifySelectedAll(bool isSelected) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String cartString = preferences.getString('cartInfo');
    var temp = (cartString == null) ? [] : json.decode(cartString);
    List<Map> tempList = (temp as List).cast();

    tempList.forEach((item) {
      item['isSelected'] = isSelected;
    });
    cartList.forEach((item) {
      item.isSelected = isSelected;
    });
    cartString = json.encode(tempList);
    preferences.setString('cartInfo', cartString);
    await getCartInfo();
  }
}