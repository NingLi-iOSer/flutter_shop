import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartCount extends StatelessWidget {

  int count = 0;

  CartCount(this.count);

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
          _operateButton(true),
          _countWdget(),
          _operateButton(false),
        ],
      ),
    );
  }

  // 加减按钮
  Widget _operateButton(bool isReduce) {
    return InkWell(
      onTap: () {

      },
      child: Container(
        alignment: Alignment.center,
        width: ScreenUtil().setWidth(50),
        height: ScreenUtil().setHeight(50),
        decoration: BoxDecoration(
          border: isReduce ? Border(right: BorderSide(width: 0.5, color: Colors.black26)) : Border(left: BorderSide(width: 0.5, color: Colors.black26))
        ),
        child: Text(
          isReduce ? '-' : '+'
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