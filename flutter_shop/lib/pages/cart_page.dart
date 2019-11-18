import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/model/cart_info_model.dart';
import 'package:flutter_shop/pages/cart_item.dart';
import 'package:provider/provider.dart';
import '../provide/cart_provider.dart';

class CartPage extends StatefulWidget {
  CartPage({Key key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  List<String> testList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('购物车'),
      ),
      body: FutureBuilder(
        future: _getCartInfo(),
        builder: (context, snapshot) {
          List<CartInfoModel> cartList = Provider.of<CartProvider>(context).cartList;
          if (snapshot.hasData) {
            return Container(
              child: ListView.builder(
                itemCount: cartList.length,
                itemBuilder: (context, index) {
                  return CartItem(cartList[index]);
                },
              ),
            );
          } else {
            return Text('暂无数据');
          }
        },
      ),
    );
  }

  Future _getCartInfo() async {
    await Provider.of<CartProvider>(context).getCartInfo();
    return 'end';
  }
}