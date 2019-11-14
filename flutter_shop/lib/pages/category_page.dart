import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/model/category_model.dart';
import 'package:provider/provider.dart';
import '../service/service_method.dart';
import 'dart:convert';
import '../provide/child_category.dart';

// 分类
class CategoryPage extends StatefulWidget {

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Scaffold(
         appBar: AppBar(title: Text('商品分类')),
         body: Container(
           child: Row(
            children: <Widget>[
              LeftCategoryNav(),
              Column(
                children: <Widget>[
                  RightCategoryNav()
                ],
              )
            ],
          ),
         )
       ),
    );
  }
}

// 左侧分类导航
class LeftCategoryNav extends StatefulWidget {
  @override
  _LeftCategoryNavState createState() => _LeftCategoryNavState();
}

class _LeftCategoryNavState extends State<LeftCategoryNav> {

  List categoryList = [];
  int listIndex = 0;

  Widget _leftInkWell(int index) {
    bool isClick = (index == listIndex);
    return InkWell(
      onTap: () {
        setState(() {
          listIndex = index;
        });
        Provider.of<ChildCategory>(context).getChildCategory(
          categoryList[index].bxMallSubDto
        );
      },
      child: Container(
        height: ScreenUtil().setWidth(100),
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
          color: isClick ? Colors.black12 : Colors.white,
          border: Border(
            bottom: BorderSide(width: 0.5, color: Colors.black12)
          )
        ),
        child: Text(
          categoryList[index].mallCategoryName,
          style: TextStyle(
            fontSize: ScreenUtil().setSp(28)
          ),
        ),
      ),
    );
  }

  @override
  void initState() { 
    _getCategoryContent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(180),
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(width: 0.5, color: Colors.black26)
        )
      ),
      child: ListView.builder(
        itemCount: categoryList.length,
        itemBuilder: (context, index) {
          return _leftInkWell(index);
        },
      ),
    );
  }

  void _getCategoryContent() async {
    await request('getCategory').then((value){
      var data = json.decode(value.toString());
      CategoryBigListModel list = CategoryBigListModel.fromJson(data['data']);
      setState(() {
        categoryList = list.data;
      });

      Provider.of<ChildCategory>(context).getChildCategory(categoryList[0].bxMallSubDto);
    });
  }
}

class RightCategoryNav extends StatefulWidget {
  RightCategoryNav({Key key}) : super(key: key);

  @override
  _RightCategoryNavState createState() => _RightCategoryNavState();
}

class _RightCategoryNavState extends State<RightCategoryNav> {

  Widget _rightInkWell(BxMallSubDtoModel item) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
        alignment: Alignment.center,
        child: Text(
          item.mallSubName,
          style: TextStyle(
            fontSize: ScreenUtil().setSp(26)
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(570),
      height: ScreenUtil().setHeight(64),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            width: 0.5,
            color: Colors.black12
          )
        )
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: Provider.of<ChildCategory>(context).childCategoryList.length,
        itemBuilder: (context, index) {
          return _rightInkWell(Provider.of<ChildCategory>(context).childCategoryList[index]);
        },
      ),
    );
  }
}
