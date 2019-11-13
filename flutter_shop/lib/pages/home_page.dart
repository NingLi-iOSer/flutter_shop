import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_shop/service/service_method.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {

  TextEditingController typeController = TextEditingController();
  String homeContent = '暂未加载首页数据';
  // banner 数据
  List swiperDataList;

  int page = 1;
  // 火爆专区商品数据
  List<Map> hotGoodsList = [];

  @override
  bool get wantKeepAlive => true;
  
  @override
  void initState() { 
    super.initState();
    // loadHomePageBelowContent();
  }
  
  @override
  Widget build(BuildContext context) {
    var parameters = {'lon': '115.12345', 'lat': '39.22112'};
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('百姓生活+'),
        ),
        body: Container(
          child:FutureBuilder(
            future: request('homePageContent', formData: parameters),
            builder: (context, snapShot) {
              if (snapShot.hasData) {
                var data = json.decode(snapShot.data.toString());
                List<Map> swiper = (data['data']['slides'] as List).cast();
                List<Map> navigatorList = (data['data']['category'] as List).cast();
                String adPicture = data['data']['advertesPicture']['PICTURE_ADDRESS'].toString();
                String leaderImage = data['data']['shopInfo']['leaderImage'].toString();
                String leaderPhone = data['data']['shopInfo']['leaderPhone'].toString();
                List<Map> recommendList = (data['data']['recommend'] as List).cast();
                String floor1Pic = data['data']['floor1Pic']['PICTURE_ADDRESS'].toString();
                List<Map> floor1Content = (data['data']['floor1'] as List).cast();
                String floor2Pic = data['data']['floor2Pic']['PICTURE_ADDRESS'].toString();
                List<Map> floor2Content = (data['data']['floor2'] as List).cast();
                String floor3Pic = data['data']['floor3Pic']['PICTURE_ADDRESS'].toString();
                List<Map> floor3Content = (data['data']['floor3'] as List).cast();

                return EasyRefresh(
                  footer: ClassicalFooter(
                    showInfo: false,
                    noMoreText: '',
                    loadReadyText: '上拉加载'
                  ),
                  child: ListView(
                    children: <Widget>[
                      SwiperDIY(swiperDataList: swiper),
                        TopNavigator(navigatorList: navigatorList),
                        AdBanner(adPicture: adPicture),
                        LeaderPhone(leaderImage: leaderImage, leaderPhone: leaderPhone),
                        Recommend(recommendList: recommendList),
                        FloorTitle(picture: floor1Pic),
                        FloorContent(floorContentList: floor1Content),
                        FloorTitle(picture: floor2Pic),
                        FloorContent(floorContentList: floor2Content),
                        FloorTitle(picture: floor3Pic),
                        FloorContent(floorContentList: floor3Content),
                        _hotGoods()
                    ],
                  ),
                  onLoad: () async {
                    await request('homePageBelowContent', formData: 1).then((value) {
                      var data = json.decode(value.toString());
                      List<Map> newGoodsList = (data['data'] as List).cast();
                      setState(() {
                        hotGoodsList.addAll(newGoodsList);
                        page++;
                      });
                    });
                  },
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
    );
  }

  void loadHomePageBelowContent() {
    
  }

  Widget hotGoodsTitle = Container(
    margin: EdgeInsets.only(top: 8),
    alignment: Alignment.center,
    padding: EdgeInsets.only(bottom: 5),
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(
          width: 0.5,
          color: Colors.black12
        )
      )
    ),
    child: Text('火爆专区'),
  );

  Widget _wrapList() {
    List<Widget> goodsList = hotGoodsList.map((value){
      return InkWell(
        onTap: (){},
        child: Container(
          padding: EdgeInsets.all(5),
          margin: EdgeInsets.only(bottom: 3),
          width: ScreenUtil().setWidth(372),
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Image.network(
                value['image'], 
                width: ScreenUtil().setWidth(370)
              ),
              Text(
                value['name'],
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: ScreenUtil().setSp(26),
                ),
              ),
              Row(
                children: <Widget>[
                  Text('¥${value['mallPrice']}'),
                  Spacer(),
                  Text(
                    '¥${value['price']}',
                    style: TextStyle(
                      color: Colors.black26,
                      decoration: TextDecoration.lineThrough
                    ),
                  ),
                  Spacer(),
                ],
              )
            ],
          ),
        ),
      );
    }).toList();

    if (hotGoodsList.isEmpty) {
      return Text('');
    } else {
      return Wrap(
        spacing: 2,
        children: goodsList,
      );
    }
  }

  Widget _hotGoods() {
    return Container(
      child: Column(
        children: <Widget>[
          hotGoodsTitle,
          _wrapList()
        ],
      ),
    );
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

// 商品推荐
class Recommend extends StatelessWidget {

  final List recommendList;

  const Recommend({Key key, this.recommendList}) : super(key: key);

  Widget _titleWidget() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(10, 2, 0, 5),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(width: 0.5, color: Colors.black12),
        )
      ),
      child: Text(
        '商品推荐',
        style: TextStyle(color: Colors.pink),
      ),
    );
  }

  Widget _item(index) {
    return InkWell(
      onTap: (){},
      child: Container(
        width: ScreenUtil().setWidth(250),
        height: ScreenUtil().setHeight(330),
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            right: BorderSide(
              width: 0.5,
              color: Colors.black12
            )
          )
        ),
        child: Column(
          children: <Widget>[
            Image.network(recommendList[index]['image'].toString()),
            Spacer(),
            Text('¥${recommendList[index]['mallPrice']}'),
            Text(
              '¥${recommendList[index]['price']}',
              style: TextStyle(
                decoration: TextDecoration.lineThrough,
                color: Colors.grey
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _itemList() {
    return Container(
      height: ScreenUtil().setHeight(330),
      child: ListView.builder(
        itemCount: recommendList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return _item(index);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(380),
      color: Colors.white,
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: <Widget>[
          _titleWidget(),
          _itemList()
        ],
      ),
    );
  }
}

// 楼层标题
class FloorTitle extends StatelessWidget {

  final String picture;

  const FloorTitle({Key key, this.picture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 8),
      child: Image.network(picture),
    );
  }
}

// 楼层内容
class FloorContent extends StatelessWidget {

  final List floorContentList;

  const FloorContent({Key key, this.floorContentList}) : super(key: key);

  Widget _firstRow() {
    return Container(
      child: Row(
        children: <Widget>[
          _goodItem(floorContentList[0]['image'].toString()),
          Column(
            children: <Widget>[
              _goodItem(floorContentList[1]['image'].toString()),
              _goodItem(floorContentList[2]['image'].toString()),
            ],
          )
        ],
      ),
    );
  }

  Widget _otherGoods() {
    return Container(
      child: Row(
        children: <Widget>[
          _goodItem(floorContentList[3]['image'].toString()),
          _goodItem(floorContentList[4]['image'].toString()),
        ],
      ),
    );
  }

  Widget _goodItem(pic) {
    return Container(
      width: ScreenUtil().setWidth(375),
      child: InkWell(
        onTap: (){},
        child: Image.network(pic),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          _firstRow(),
          _otherGoods()
        ],
      ),
    );
  }
}

