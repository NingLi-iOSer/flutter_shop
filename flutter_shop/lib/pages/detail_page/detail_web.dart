import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import '../../provide/detail_info_provider.dart';

class DetailWeb extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final goodsData = Provider.of<DetailInfoProvider>(context).detail.data.goodInfo.goodsDetail;
    return Container(
      child: Html(
        data: goodsData,
      ),
    );
  }
}