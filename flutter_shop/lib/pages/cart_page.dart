import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartPage extends StatefulWidget {
  CartPage({Key key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  List<String> testList = [];

  @override
  Widget build(BuildContext context) {
    return Container(
       child: Column(
         children: <Widget>[
           Container(
             height: ScreenUtil().setHeight(500),
             child: ListView.builder(
               itemCount: testList.length,
               itemBuilder: (context, index) {
                 return ListTile(title: Text(testList[index]),);
               },
             ),
           ),

           RaisedButton(
             child: Text('add'),
             onPressed: _add,
           ),

           RaisedButton(
             child: Text('delete'),
             onPressed: _delete,
           )
         ],
       )
    );
  }

  void _add() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String testString = "Test String";
    testList.add(testString);
    preferences.setStringList('test', testList);
    _show();
  }

  void _delete() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove('test');
    setState(() {
      testList = [];
    });
  }

  void _show() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var list = preferences.getStringList('test');
    if (list != null) {
      setState(() {
        testList = list;
      });
    }
  }
}