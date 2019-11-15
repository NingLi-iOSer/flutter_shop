import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'router_handler.dart';

class Routers {
  static String root = '/';
  static String detailPage = '/detail';
  static void configureRouters(Router router) {
    router.notFoundHandler = new Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
        print('Error: Not Found');
      }
    );
    router.define(detailPage, handler: detailHandler, transitionType: TransitionType.cupertino);
  }
}