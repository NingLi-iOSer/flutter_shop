import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/model/detail_model.dart';
import 'package:flutter_shop/provide/current_index_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
          Stack(
            children: <Widget>[
              InkWell(
                onTap: () {
                  Provider.of<CurrentIndexProvider>(context).changeIndex(2);
                  Navigator.pop(context);
                },
                child: Container(
                  width: ScreenUtil().setWidth(110),
                  height: ScreenUtil().setHeight(88),
                  child: Icon(Icons.shopping_cart, color: Colors.red, size: 32),
                ),
              ),
              Positioned(
                top: 5,
                right: 5,
                child: Container(
                  padding: EdgeInsets.fromLTRB(5, 2, 5, 2),
                  decoration: BoxDecoration(
                    color: Colors.pink,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(width: 1, color: Colors.white)
                  ),
                  child: Text(
                    '${Provider.of<CartProvider>(context).totalCount}',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: ScreenUtil().setSp(22)
                    ),
                  ),
                ),
              )
            ],
          ),
          InkWell(
            onTap: () {
              GoodInfo goodInfo = Provider.of<DetailInfoProvider>(context).detail.data.goodInfo;
              Provider.of<CartProvider>(context).save(goodInfo.goodsId, goodInfo.goodsName, 1, goodInfo.presentPrice, goodInfo.oriPrice, goodInfo.image1);
              Fluttertoast.showToast(
                msg: '加入购物车成功',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
              );
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
            onTap: () {
              Provider.of<CartProvider>(context).clear();
            },
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