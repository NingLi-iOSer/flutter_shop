import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import '../pages/detail_page.dart';

Handler detailHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
    String goodsId = parameters['id'].first;
    return DetailPage(goodsId);
  }
);