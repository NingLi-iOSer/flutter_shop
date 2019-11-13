import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_shop/service/service_method.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

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
                  List<Map> navigatorList = (data['data']['category'] as List).cast();
                  String adPicture = data['data']['advertesPicture']['PICTURE_ADDRESS'].toString();
                  String leaderImage = data['data']['shopInfo']['leaderImage'].toString();
                  String leaderPhone = data['data']['shopInfo']['leaderPhone'].toString();

                  return Column(
                    children: <Widget>[
                      SwiperDIY(swiperDataList: swiper),
                      TopNavigator(navigatorList: navigatorList),
                      AdBanner(adPicture: adPicture),
                      LeaderPhone(leaderImage: leaderImage, leaderPhone: leaderPhone),
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

// 轮播器
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

// 分类
class TopNavigator extends StatelessWidget {

  final List navigatorList;

  const TopNavigator({Key key, this.navigatorList}) : super(key: key);

  Widget _getNavigatorItem(BuildContext context, item) {
    return InkWell(
      onTap: () {
        print('Tap Navigator');
      },
      child: Column(
        children: <Widget>[
          Image.network(item['image'], width: ScreenUtil().setWidth(95),),
          Text(item['mallCategoryName'])
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (navigatorList.length > 10) {
      navigatorList.removeRange(10, navigatorList.length);
    }
    return Container(
      margin: EdgeInsets.only(top: 5),
      height: ScreenUtil().setHeight(320),
      padding: EdgeInsets.all(3),
      child: GridView.count(
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 5,
        padding: EdgeInsets.all(5),
        children: navigatorList.map((item) {
          return _getNavigatorItem(context, item);
        }).toList(),
      )
    );
  }
}

class AdBanner extends StatelessWidget {

  final String adPicture;

  const AdBanner({Key key, this.adPicture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5),
      child: Image.network(adPicture),
    );
  }
}

// 店长电话
class LeaderPhone extends StatelessWidget {

  final String leaderImage;
  final String leaderPhone;

  const LeaderPhone({Key key, this.leaderImage, this.leaderPhone}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: _launchURL,
        child: Image.network(leaderImage),
      ),
    );
  }

  void _launchURL() async {
    String url = 'tel:' + leaderPhone;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('url 无效');
    }
  }
}