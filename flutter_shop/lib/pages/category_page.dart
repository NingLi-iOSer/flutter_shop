import 'package:flutter/material.dart';
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
      print(value);
    });
  }
}