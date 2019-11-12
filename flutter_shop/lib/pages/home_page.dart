import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_shop/service/service_method.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  TextEditingController typeController = TextEditingController();
  String homeContent = '暂未加载首页数据';

  @override
  void initState() {
    super.initState();
    loadHomePageContent();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('百姓生活+'),
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Text(homeContent),
          )
        )
      )
    );
  }

  void loadHomePageContent() {
    getHomePageContent().then((value) {
      setState(() {
        homeContent = value.toString();
      });
    });
  }
}