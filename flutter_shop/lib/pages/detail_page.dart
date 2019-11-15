import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provide/detail_info_provider.dart';

class DetailPage extends StatelessWidget {

  final String goodId;

  DetailPage(this.goodId);

  @override
  Widget build(BuildContext context) {
    _getGoodInfo(context);
    return Container(
      color: Colors.white,
      child: Center(
        child: Text('商品Id: $goodId'),
      ),
    );
  }

  void _getGoodInfo(BuildContext context) async {
    await Provider.of<DetailInfoProvider>(context).getDetailInfo(goodId);
  }
}