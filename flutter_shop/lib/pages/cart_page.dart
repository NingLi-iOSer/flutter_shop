import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/model/cart_info_model.dart';
import 'package:flutter_shop/pages/cart_page/cart_item.dart';
import 'package:flutter_shop/pages/cart_page/cart_toolbar.dart';
import 'package:provider/provider.dart';
import '../provide/cart_provider.dart';

class CartPage extends StatefulWidget {
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
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(bottom: 58),
                    child: ListView.builder(
                      itemCount: cartList.length,
                      itemBuilder: (context, index) {
                        return CartItem(cartList[index]);
                      },
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: CartToolbar(),
                  )
                ],
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
