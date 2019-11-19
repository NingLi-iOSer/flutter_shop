import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/model/category_goods_list_model.dart';
import 'package:flutter_shop/model/category_model.dart';
import 'package:flutter_shop/routers/application.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../service/service_method.dart';
import 'dart:convert';
import '../provide/child_category.dart';
import '../provide/category_goods_list_provider.dart';

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
                  RightCategoryNav(),
                  CategoryGoodsList()
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

  List<CategoryBigModel> categoryList = [];
  int listIndex = 0;

  Widget _leftInkWell(int index) {
    bool isClick = (index == listIndex);
    return InkWell(
      onTap: () {
        setState(() {
          listIndex = index;
        });
        Provider.of<ChildCategory>(context).getChildCategory(
          categoryList[index].mallCategoryId,
          categoryList[index].bxMallSubDto
        );
        _getMallGoods(categoryId: categoryList[index].mallCategoryId);
      },
      child: Container(
        height: ScreenUtil().setWidth(100),
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
          color: isClick ? Color.fromRGBO(242, 242, 242, 1) : Colors.white,
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
    _getMallGoods();
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

      Provider.of<ChildCategory>(context).getChildCategory(categoryList[0].mallCategoryId, categoryList[0].bxMallSubDto);
    });
  }

  void _getMallGoods({categoryId}) async {
    var formData = {
      'categoryId': categoryId == null ? 4 : categoryId,
      'categorySubId': '',
      'page': 1
    };
    await request('getMallGoods', formData: formData).then((value){
      var data = json.decode(value.toString());
      CategoryGoodsListModel model = CategoryGoodsListModel.fromJson(data);
      Provider.of<CategoryGoodsListProvider>(context).getCategoryGoodsList(model.data);
    });
  }
}

class RightCategoryNav extends StatefulWidget {
  RightCategoryNav({Key key}) : super(key: key);

  @override
  _RightCategoryNavState createState() => _RightCategoryNavState();
}

class _RightCategoryNavState extends State<RightCategoryNav> {

  Widget _rightInkWell(int index, BxMallSubDtoModel item) {
    return InkWell(
      onTap: () {
        Provider.of<ChildCategory>(context).changeChildIndex(index, item.mallSubId);
        _getMallGoods(categoryId: item.mallSubId);
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
        alignment: Alignment.center,
        child: Text(
          item.mallSubName,
          style: TextStyle(
            fontSize: ScreenUtil().setSp(26),
            color: Provider.of<ChildCategory>(context).childIndex == index ? Colors.pink : Colors.black,
          ),
        ),
      ),
    );
  }

  void _getMallGoods({categoryId}) async {
    var formData = {
      'categoryId': Provider.of<ChildCategory>(context).categoryId,
      'categorySubId': categoryId,
      'page': 1
    };
    await request('getMallGoods', formData: formData).then((value){
      var data = json.decode(value.toString());
      CategoryGoodsListModel model = CategoryGoodsListModel.fromJson(data);
      if (model.data == null) {
        Provider.of<CategoryGoodsListProvider>(context).getCategoryGoodsList([]);
      } else {
        Provider.of<CategoryGoodsListProvider>(context).getCategoryGoodsList(model.data);
      }
    });
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
          return _rightInkWell(index, Provider.of<ChildCategory>(context).childCategoryList[index]);
        },
      ),
    );
  }
}

class CategoryGoodsList extends StatefulWidget {
  @override
  _CategoryGoodsListState createState() => _CategoryGoodsListState();
}

class _CategoryGoodsListState extends State<CategoryGoodsList> {

  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    if (Provider.of<CategoryGoodsListProvider>(context).goodsList.isEmpty) {
      return Text('暂无数据');
    } else {
      try {
        if (Provider.of<ChildCategory>(context).page == 1) {
          scrollController.jumpTo(0);
        }
      } catch (e) {
      }
      return Expanded(
        child: Container(
          width: ScreenUtil().setWidth(570),
          child: EasyRefresh(
            footer: ClassicalFooter(
              key: Key('footer'),
              noMoreText: Provider.of<ChildCategory>(context).noMoreText,
              loadText: 'Loading',
              loadReadyText: 'Ready to load',
              loadedText: '加载完成',
              showInfo: false
            ),
            child: ListView.builder(
              itemCount: Provider.of<CategoryGoodsListProvider>(context).goodsList.length,
              itemBuilder: (context, index) {
                return _goodsItem(index);
              },
              controller: scrollController,
            ),
            onLoad: () async {
              _getMoreGoods();
            },
          ),
        ),
      );
    }
  }

  // 加载更多商品
  void _getMoreGoods() {
    Provider.of<ChildCategory>(context).increacePage();
    var formData = {
      'categoryId': Provider.of<ChildCategory>(context).categoryId,
      'categorySubId': Provider.of<ChildCategory>(context).subId,
      'page': Provider.of<ChildCategory>(context).page
    };
    request('getMallGoods', formData: formData).then((value){
      var data = json.decode(value.toString());
      CategoryGoodsListModel model = CategoryGoodsListModel.fromJson(data);
      if (model.data == null) {
        Fluttertoast.showToast(
          msg: '没有更多了',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.pink,
          textColor: Colors.white,
        );
        Provider.of<ChildCategory>(context).changeNoMore('没有更多了');
      } else {
        Provider.of<CategoryGoodsListProvider>(context).getMoreGoodsList(model.data);
      }
    });
  }

  Widget _goodsImage(index) {
    return Container(
      width: ScreenUtil().setWidth(200),
      child: Image.network(Provider.of<CategoryGoodsListProvider>(context).goodsList[index].image),
    );
  }

  Widget _goodsTitle(index) {
    return Container(
      width: ScreenUtil().setWidth(350),
      child: Text(Provider.of<CategoryGoodsListProvider>(context).goodsList[index].goodsName, overflow: TextOverflow.ellipsis,),
    );
  }

  Widget _goodsPrice(index) {
    return Container(
      width: ScreenUtil().setWidth(350),
      margin: EdgeInsets.only(top: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text(
            '¥${Provider.of<CategoryGoodsListProvider>(context).goodsList[index].presentPrice}  ',
            style: TextStyle(
              color: Colors.pink,
              fontSize: ScreenUtil().setSp(28)
            ),
          ),
          Text(
            '¥${Provider.of<CategoryGoodsListProvider>(context).goodsList[index].oriPrice}',
            style: TextStyle(
              decoration: TextDecoration.lineThrough,
              color: Colors.grey,
              fontSize: ScreenUtil().setSp(24),
            ),
          )
        ],
      ),
    );
  }

  Widget _goodsItem(index) {
    return InkWell(
      onTap: () {
        Application.router.navigateTo(context, '/detail?id=${Provider.of<CategoryGoodsListProvider>(context).goodsList[index].goodsId}');
      },
      child: Container(
        padding: EdgeInsets.only(top: 5, bottom: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              width: 0.5,
              color: Colors.black12
            )
          )
        ),
        child: Row(
          children: <Widget>[
            _goodsImage(index),
            Column(
              children: <Widget>[
                _goodsTitle(index),
                _goodsPrice(index)
              ],
            )
          ],
        ),
      ),
    );
  }
}