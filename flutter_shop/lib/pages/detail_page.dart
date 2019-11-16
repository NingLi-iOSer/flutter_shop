import 'package:flutter/material.dart';
import 'package:flutter_shop/pages/detail_page/detail_explain.dart';
import 'package:flutter_shop/pages/detail_page/detail_top_area.dart';
import 'package:flutter_shop/service/service_method.dart';
import 'package:provider/provider.dart';
import '../provide/detail_info_provider.dart';

class DetailPage extends StatelessWidget {

  final String goodId;

  DetailPage(this.goodId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('商品详情'),
      ),
      body: FutureBuilder(
        future: _getGoodInfo(context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              child: Column(
                children: <Widget>[
                  DetailTopArea(),
                  DetailExplain()
                ],
              ),
            );
          } else {
            return Text('Loading');
          }
        },
      ),
    );
  }

  Future _getGoodInfo(BuildContext context) async {
    await Provider.of<DetailInfoProvider>(context, listen: false).getDetailInfo(goodId);
    return 'Load Completed';
  }
}