import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/provide/cart_provider.dart';
import 'package:provider/provider.dart';

class CartCount extends StatelessWidget {

  int count = 0;
  final String goodsId;

  CartCount(this.goodsId, this.count);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(155),
      height: ScreenUtil().setHeight(50),
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        border: Border.all(width: 0.5, color: Colors.black26),
      ),
      child: Row(
        children: <Widget>[
          _operateButton(context, true),
          _countWdget(),
          _operateButton(context, false),
        ],
      ),
    );
  }

  // 加减按钮
  Widget _operateButton(BuildContext context, bool isReduce) {
    return InkWell(
      onTap: () {
        if (isReduce && count > 1) {
          count--;
        } else if (!isReduce) {
          count++;
        } else {
          return;
        }
        Provider.of<CartProvider>(context).modifyCartGoodsCount(goodsId, count);
      },
      child: Container(
        alignment: Alignment.center,
        width: ScreenUtil().setWidth(50),
        height: ScreenUtil().setHeight(50),
        decoration: BoxDecoration(
          color: (isReduce && count <= 1) ? Colors.black12 : Colors.white,
          border: isReduce ? Border(right: BorderSide(width: 0.5, color: Colors.black26)) : Border(left: BorderSide(width: 0.5, color: Colors.black26))
        ),
        child: Text(
          (isReduce && count <= 1) ? '' : isReduce ? '-' : '+'
        ),
      ),
    );
  }

  // 数量
  Widget _countWdget() {
    return Container(
      width: ScreenUtil().setWidth(49),
      height: ScreenUtil().setHeight(50),
      alignment: Alignment.center,
      child: Text(
        '$count'
      ),
    );
  }
}