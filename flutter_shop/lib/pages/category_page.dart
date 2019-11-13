import 'package:flutter/material.dart';
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
    getCategoryContent();
    return Container(
       child: Center(
         child: Text('分类'),
       ),
    );
  }

  void getCategoryContent() {
    request('getCategory').then((value){
      var data = json.decode(value.toString());
      CategoryBigListModel list = CategoryBigListModel.fromJson(data['data']);
      list.data.forEach((item)=>print(item.mallCategoryName));
    });
  }
}