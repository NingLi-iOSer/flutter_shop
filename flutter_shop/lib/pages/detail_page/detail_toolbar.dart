import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/model/detail_model.dart';
import 'package:provider/provider.dart';
import '../../provide/detail_info_provider.dart';
import '../../provide/cart_provider.dart';

class DetailToolbar extends StatelessWidget {
  const DetailToolbar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(88),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          InkWell(
            onTap: () {
              Provider.of<CartProvider>(context).clear();
            },
            child: Container(
              width: ScreenUtil().setWidth(110),
              child: Icon(Icons.shopping_cart, color: Colors.red, size: 32),
            ),
          ),
          InkWell(
            onTap: () {
              GoodInfo goodInfo = Provider.of<DetailInfoProvider>(context).detail.data.goodInfo;
              Provider.of<CartProvider>(context).save(goodInfo.goodsId, goodInfo.goodsName, 1, goodInfo.presentPrice, goodInfo.oriPrice, goodInfo.image1);
            },
            child: Container(
              height: ScreenUtil().setHeight(88),
              width: ScreenUtil().setWidth(320),
              alignment: Alignment.center,
              color: Colors.green,
              child: Text(
                '加入购物车',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: ScreenUtil().setSp(32)
                )
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: Container(
              height: ScreenUtil().setHeight(88),
              width: ScreenUtil().setWidth(320),
              alignment: Alignment.center,
              color: Colors.red,
              child: Text(
                '立即购买',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: ScreenUtil().setSp(32)
                )
              ),
            ),
          )
        ],
      ),
    );
  }
}