import 'dart:io';

import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'homeLayout.dart';
import 'pages/moveDetail.dart';
import 'pages/playMovie/index.dart';

const String testDevice = 'YOUR_DEVICE_ID';

void main() {
  // debugPaintSizeEnabled = true;
  runApp(new MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    FirebaseAdMob.instance.initialize(appId: FirebaseAdMob.testAppId);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "风影院",
      theme: new ThemeData(
          primaryColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.grey[700]),
          backgroundColor: Colors.white,
          appBarTheme:
              AppBarTheme(iconTheme: IconThemeData(color: Colors.grey[700]))),
      initialRoute: "/",
      onGenerateRoute: (RouteSettings settings) {
        print('build route for ${settings.name}');
        var routes = <String, WidgetBuilder>{
          "/": (ctx) => MyHomePage(),
          "/moviedetail": (ctx) => MovieDetail(settings.arguments),
          "/playmovie": (ctx) => PlayMovie(settings.arguments),
        };
        WidgetBuilder builder = routes[settings.name];
        return MaterialPageRoute(
            builder: (ctx) => builder(ctx), settings: settings);
      },
      // home: new MyHomePage(title: "home"),
      // routes: routers
    );
  }
}
