import 'package:flutter/material.dart';
import 'package:flutter_shop/provide/cart_provider.dart';
import 'package:flutter_shop/provide/category_goods_list_provider.dart';
import 'package:flutter_shop/provide/child_category.dart';
import 'package:flutter_shop/provide/counter.dart';
import 'package:flutter_shop/provide/detail_info_provider.dart';
import 'package:flutter_shop/routers/application.dart';
import 'package:flutter_shop/routers/routers.dart';
import './pages/index_page.dart';
import 'package:provider/provider.dart';
import 'package:fluro/fluro.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Counter()),
        ChangeNotifierProvider.value(value: ChildCategory()),
        ChangeNotifierProvider.value(value: CategoryGoodsListProvider()),
        ChangeNotifierProvider.value(value: DetailInfoProvider()),
        ChangeNotifierProvider.value(value: CartProvider()),
      ],
      child: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final Router router = Router();
    Routers.configureRouters(router);
    Application.router = router;

    return Container(
      child: MaterialApp(
        title: '生活百姓+',
        onGenerateRoute: Application.router.generator,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.pink,
        ),
        home: IndexPage(),
      ),
    );
  }
}