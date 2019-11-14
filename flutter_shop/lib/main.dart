import 'package:flutter/material.dart';
import 'package:flutter_shop/provide/counter.dart';
import './pages/index_page.dart';
import 'package:provider/provider.dart';

// void main() => runApp(MyApp());
void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Counter()),
      ],
      child: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
        title: '生活百姓+',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.pink,
        ),
        home: IndexPage(),
      ),
    );
  }
}