import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartToolbar extends StatelessWidget {
  const CartToolbar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(5, 5, 10, 5),
      height: ScreenUtil().setHeight(100),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(color: Color.fromRGBO(232, 232, 232, 0.6), offset: Offset(0, -1), blurRadius: 1)
        ]
      ),
      child: Row(
        children: <Widget>[
          _select(),
          _priceArea(),
          _goButton(),
        ],
      ),
    );
  }

  // 全选
  Widget _select() {
    return Container(
      child: Row(
        children: <Widget>[
          Checkbox(
            value: true,
            activeColor: Colors.pink,
            onChanged: (flag) {

            },
          ),
          Text(
            '全选',
            style: TextStyle(
              fontSize: ScreenUtil().setSp(28)
            ),
          )
        ],
      ),
    );
  }

  // 合计
  Widget _priceArea() {
    return Container(
      width: ScreenUtil().setWidth(430),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                width: ScreenUtil().setWidth(430),
                alignment: Alignment.centerRight,
                child: RichText(
                  maxLines: 1,
                  // overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.end,
                  text: TextSpan(
                    text: '合计：',
                    style: TextStyle(fontSize: ScreenUtil().setSp(32), color: Colors.black),
                    children: <TextSpan>[
                      TextSpan(
                        text: '¥19999',
                        style: TextStyle(fontSize: ScreenUtil().setSp(32), color: Colors.pink),
                      )
                    ]
                  ),
                )
              ),
            ],
          ),
          Text(
            '满10元免配送费',
            style: TextStyle(
              fontSize: ScreenUtil().setSp(22),
              color: Colors.black54
            ),
          )
        ],
      ),
    );
  }

  // 结算
  Widget _goButton() {
    return InkWell(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.only(left: 10),
        padding: EdgeInsets.all(10),
        width: ScreenUtil().setHeight(120),
        decoration: BoxDecoration(
          color: Colors.pink,
          borderRadius: BorderRadius.circular(4)
        ),
        child: Text(
          '结算(2)',
          style: TextStyle(
            color: Colors.white
          ),
        ),
      ),
    );
  }
}