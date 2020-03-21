
import 'package:flutter/material.dart';
import 'package:learnflutter/pages/category.dart';
import 'pages/home.dart';
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> tabs = ["首页", "电影", "电视剧", "动漫", "综艺"];
  final List<String> tabPY = ["index","dy", "dsj", "dm", "zy"];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new DefaultTabController(
      length: tabs.length,
      child: new Scaffold(
        appBar: new AppBar(
          title: new Text("风影院"),
          actions: <Widget>[
            new IconButton(
              icon: new Icon(Icons.search),
              tooltip: "search",
              onPressed: null,
            )
          ],
          bottom: new TabBar(
              isScrollable: true,
              tabs: tabs.map((String tab) {
                return new Tab(text: tab);
              }).toList()),
        ),
        body: new TabBarView(
          children: buildList(),
        ),
        drawer: new Drawer(
          child: new Text("drawer"),
        ),
      ),
    );
  }

  List<Widget> buildList() {
    List<Widget> ws = [];
    ws.add(new HomePage());
    for (var i = 1; i < tabs.length ; i++) {
      ws.add(new CategoryPage(tabPY[i]));
    }

    return ws;
  }
}
