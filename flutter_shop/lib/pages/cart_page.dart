import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provide/counter.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: <Widget>[
            Number(),
            MyButton()
          ],
        ),
      ),
    );
  }
}

class Number extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 200),
      child: Text(
        '${Provider.of<Counter>(context).value}',
        style: Theme.of(context).textTheme.display1
      ),
    );
  }
}

class MyButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton(
        child: Text('+'),
        onPressed: (){
          Provider.of<Counter>(context).increace();
        },
      ),
    );
  }
}