import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provide/counter.dart';

class MemberPage extends StatelessWidget {
  const MemberPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          '${Provider.of<Counter>(context).value}',
          style: Theme.of(context).textTheme.display1
        ),
      ),
    );
  }
}