import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../provide/detail_info_provider.dart';

class DetailTabbar extends StatelessWidget {
  const DetailTabbar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          _tabbarItem(context, true, Provider.of<DetailInfoProvider>(context).isSelectedLeft),
          _tabbarItem(context, false, Provider.of<DetailInfoProvider>(context).isSelectedLeft)
        ],
      ),
    );
  }

  Widget _tabbarItem(BuildContext context, bool isLeft, bool isSelectedLeft) {
    return InkWell(
      onTap: () {
        Provider.of<DetailInfoProvider>(context).changeTabbarStatus(isLeft);
      },
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.all(10),
        width: ScreenUtil().setWidth(375),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: (isSelectedLeft && isLeft) || (!isSelectedLeft && !isLeft) ? Colors.pink : Colors.white
            )
          )
        ),
        child: Text(
          isLeft ? '详情' : '评价',
          style: TextStyle(
            color: (isSelectedLeft && isLeft) || (!isSelectedLeft && !isLeft) ? Colors.pink : Colors.black
          ),
        ),
      ),
    );
  }
}