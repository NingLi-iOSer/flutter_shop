import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/model/cart_info_model.dart';
import 'package:flutter_shop/pages/cart_page/cart_count.dart';
import 'package:provider/provider.dart';
import '../../provide/cart_provider.dart';

class CartItem extends StatelessWidget {
  final CartInfoModel model;

  CartItem(this.model);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: 2),
      padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
      child: Row(
        children: <Widget>[
          _cartCheckButton(),
          _cartImage(),
          _cartName(),
          _cartPrice(context, model),
        ],
      ),
    );
  }

  // 多选按钮
  Widget _cartCheckButton() {
    return Container(
      child: Checkbox(
        value: model.isSelected,
        activeColor: Colors.pink,
        onChanged: (flag) {
          
        },
      ),
    );
  }

  // 商品图片
  Widget _cartImage() {
    return Container(
      margin: EdgeInsets.only(top: 5, bottom: 5),
      width: ScreenUtil().setWidth(160),
      height: ScreenUtil().setHeight(160),
      decoration: BoxDecoration(
        border: Border.all(
          width: 0.5,
          color: Colors.black12
        )
      ),
      child: Image.network(model.images),
    );
  }

  // 商品名称
  Widget _cartName() {
    return Container(
      alignment: Alignment.topLeft,
      padding: EdgeInsets.all(10),
      width: ScreenUtil().setWidth(320),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            model.goodsName,
            style: TextStyle(color: Colors.black, fontSize: ScreenUtil().setSp(28)),
          ),
          CartCount(),
        ],
      ),
    );
  }

  // 商品价格
  Widget _cartPrice(BuildContext context, CartInfoModel item) {
    return Container(
      width: ScreenUtil().setWidth(150),
      alignment: Alignment.centerRight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text(
            '¥${model.price}',
            style: TextStyle(fontSize: ScreenUtil().setSp(27)),
          ),
          Text(
            '¥${model.oriPrice}',
            style: TextStyle(
              fontSize: ScreenUtil().setSp(23), 
              color: Colors.black38,
              decoration: TextDecoration.lineThrough
            ),
          ),
          SizedBox(height: 10,),
          Container(
            child: InkWell(
              onTap: () {
                Provider.of<CartProvider>(context).deleteCartGoods(item.goodsId);
              },
              child: Icon(Icons.delete, color: Colors.black26),
            )
          )
        ],
      ),
    );
  }
}