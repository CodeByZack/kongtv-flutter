import 'package:flutter/material.dart';
import 'package:learnflutter/base/global.dart';
import 'package:learnflutter/pages/category.dart';
import 'buildCustomWidget/appBar.dart';
import 'pages/home.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
      length: TAB_TITLES.length,
      child: Scaffold(
        appBar: buildAppBar("风影院", TAB_TITLES),
        body: TabBarView(
          children: buildTabBarViews(),
        ),
        drawer: Drawer(
          child: MyDrawer(),
        ),
      ),
    );
  }

  List<Widget> buildTabBarViews() {
    List<Widget> ws = [];
    ws.add(new HomePage());
    for (var i = 1; i < TAB_TITLES.length; i++) {
      ws.add(new CategoryPage(MOVIE_TYPE[i]));
    }
    return ws;
  }
}

class MyDrawer extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        Image.asset("imgs/logo.png",height: 40)
      ],
    );
  }
  
  
}
