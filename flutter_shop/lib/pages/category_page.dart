import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/model/category_model.dart';
import '../service/service_method.dart';
import 'dart:convert';

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

  List<CategoryBigModel> categoryList = [];

  Widget _leftInkWell(int index) {
    return InkWell(
      child: Container(
        height: ScreenUtil().setWidth(100),
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
          color: Colors.white,
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
    });
  }
}