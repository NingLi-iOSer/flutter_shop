import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MemberPage extends StatelessWidget {
  const MemberPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('会员中心'),
        elevation: 0,
      ),
      body: Container(
        width: ScreenUtil().setWidth(750),
        child: ListView (
          children: <Widget>[
            _personalWidget(),
            _myOrder(),
            _orderTypeRow(),
            _actionList()
          ],
        ),
      ),
    );
  }

  /// 个人信息
  Widget _personalWidget() {
    return Container(
      height: ScreenUtil().setHeight(400),
      width: ScreenUtil().setWidth(750),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[
            Colors.pink,
            Colors.pink[300]
          ]
        )
      ),
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 20),
            width: ScreenUtil().setWidth(240),
            height: ScreenUtil().setHeight(240),
            child: ClipOval(
              child: Image.network('https://user-gold-cdn.xitu.io/2019/3/7/16956cee70a4bd79?imageView2/1/w/100/h/100/q/85/interlace/1', fit: BoxFit.cover),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 15),
            child: Text(
              '老司机',
              style: TextStyle(
                fontSize: ScreenUtil().setSp(36),
                color: Colors.white
              ),
            ),
          )
        ],
      ),
    );
  }

  // 我的订单
  Widget _myOrder() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.only(left: 15, right: 15),
      color: Colors.white,
      height: ScreenUtil().setHeight(88),
      width: ScreenUtil().setWidth(750),
      child: InkWell(
        onTap: () {},
        child: Row(
          children: <Widget>[
            Icon(Icons.format_list_bulleted, size: 28),
            Container(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                '我的订单',
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(32)
                ),
              ),
            ),
            Spacer(),
            Icon(Icons.arrow_forward_ios, size: 20, color: Colors.black38)
          ],
        ),
      ),
    );
  }

  // 订单类型 Row
  Widget _orderTypeRow() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(130),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          _orderTypeItem('待付款', Icons.camera),
          _orderTypeItem('待发货', Icons.desktop_mac),
          _orderTypeItem('待收货', Icons.transfer_within_a_station),
          _orderTypeItem('待评价', Icons.chrome_reader_mode),
        ],
      ),
    );
  }

  // 订单类型 item
  Widget _orderTypeItem(String text, IconData icon) {
    return Container(
      padding: EdgeInsets.all(8),
      height: ScreenUtil().setHeight(130),
      width: ScreenUtil().setWidth(187),
      child: Column(
        children: <Widget>[
          Icon(icon, size: 32, color: Colors.black45),
          Container(
            margin: EdgeInsets.only(top: 2),
            child: Text(
              text,
              style: TextStyle(
                fontSize: ScreenUtil().setSp(28)
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _actionList() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(264),
      color: Colors.white,
      child: ListView(
        children: <Widget>[
          _commonListTile('优惠券', Icons.euro_symbol),
          _commonListTile('地址管理', Icons.queue_music),
          _commonListTile('客服电话', Icons.phone),
        ],
      ),
    );
  }

  Widget _commonListTile(String text, IconData icon) {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15),
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(88),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(width: 0.5, color: Colors.black12)
        )
      ),
      child: Row(
        children: <Widget>[
          Icon(icon, size: 28, color: Colors.black45),
          Container(
            margin: EdgeInsets.only(left: 5),
            child: Text(
              text,
              style: TextStyle(
                fontSize: ScreenUtil().setSp(32)
              ),
            ),
          ),
          Spacer(),
          Icon(Icons.arrow_forward_ios, size: 20, color: Colors.black38)
        ],
      ),
    );
  }
}