import 'package:flutter/material.dart';
import 'package:learnflutter/main.dart';
import 'package:learnflutter/pages/moveDetail.dart';

Map<String, WidgetBuilder> routes = {
  "/" : (BuildContext context) => new MyHomePage(),
  "/moviedetail" : (BuildContext context) => new MovieDetail()
};