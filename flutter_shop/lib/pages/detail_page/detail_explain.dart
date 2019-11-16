import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailExplain extends StatelessWidget {
  const DetailExplain({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(88),
      color: Colors.white,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 12),
      margin: EdgeInsets.only(top: 10, bottom: 10),
      child: Text(
        '说明：>急速送达 >正品保证',
        style: TextStyle(
          color: Colors.yellow[900]
        )
      ),
    );
  }
}