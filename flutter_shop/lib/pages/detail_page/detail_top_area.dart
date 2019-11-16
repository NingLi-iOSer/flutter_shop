import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/model/detail_model.dart';
import 'package:provider/provider.dart';
import '../../provide/detail_info_provider.dart';

class DetailTopArea extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final GoodInfo goodInfo = Provider.of<DetailInfoProvider>(context).detail.data.goodInfo;
    return Container(
      child: Column(
        children: <Widget>[
          _goodsImage(goodInfo.image1),
          _goodsName(goodInfo.goodsName),
          _goodsNum(goodInfo.goodsSerialNumber),
          _goodsPrice(goodInfo.presentPrice, goodInfo.oriPrice),
        ],
      ),
    );
  }

  // 商品图片
  Widget _goodsImage(image) {
    return Image.network(
      image,
      width: ScreenUtil().setWidth(740),
    );
  }

  // 商品名称
  Widget _goodsName(name) {
    return Container(
      width: ScreenUtil().setWidth(730),
      padding: EdgeInsets.only(left: 8),
      color: Colors.white,
      child: Text(
        name,
        style: TextStyle(
          color: Colors.black,
          fontSize: ScreenUtil().setSp(32)
        ),
      ),
    );
  }

  // 编号
  Widget _goodsNum(num) {
    return Container(
      width: ScreenUtil().setWidth(730),
      padding: EdgeInsets.only(left: 8, top: 6),
      color: Colors.white,
      child: Text(
        '编号：$num',
        style: TextStyle(
          color: Colors.grey
        ),
      ),
    );
  }

  // 价格
  Widget _goodsPrice(price, originalPrice) {
    return Container(
      width: ScreenUtil().setWidth(730),
      padding: EdgeInsets.only(left: 8, top: 10, bottom: 8),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Text(
            '¥$price',
            style: TextStyle(
              color: Colors.orange[900],
              fontSize: ScreenUtil().setSp(32)
            ),
          ),
          SizedBox(width: 30),
          Text(
            '市场价：'
          ),
          Text(
            '¥$originalPrice',
            style: TextStyle(
              color: Colors.grey,
              decoration: TextDecoration.lineThrough
            ),
          ),
        ],
      ),
    );
  }
}