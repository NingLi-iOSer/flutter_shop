import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_shop/service/service_method.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  TextEditingController typeController = TextEditingController();
  String homeContent = '暂未加载首页数据';
  // banner 数据
  List swiperDataList;

  @override
  void initState() {
    super.initState();
    // loadHomePageContent();
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
            child: FutureBuilder(
              future: getHomePageContent(),
              builder: (context, snapShot) {
                if (snapShot.hasData) {
                  var data = json.decode(snapShot.data.toString());
                  List<Map> swiper = (data['data']['slides'] as List).cast();
                  return Column(
                    children: <Widget>[
                      SwiperDIY(swiperDataList: swiper),
                    ],
                  );
                } else {
                  return Center(
                    child: Text('Loading...'),
                  );
                }
              },
            ),
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

class SwiperDIY extends StatelessWidget {
  const SwiperDIY({Key key, this.swiperDataList}) : super(key: key);

  final List swiperDataList;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    return Container(
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(333),
      child: Swiper(
        itemBuilder: (context, index) {
          return Image.network(swiperDataList[index]['image'].toString(), fit: BoxFit.fill,);
        },
        itemCount: swiperDataList.length,
        autoplay: true,
        pagination: SwiperPagination(),
        scale: 0.75,
        duration: 1000,
      ),
    );
  }
}