
import 'package:flutter/material.dart';
import 'package:learnflutter/base/global.dart';
import 'package:learnflutter/pages/category.dart';
import 'pages/home.dart';
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new DefaultTabController(
      length: TAB_TITLES.length,
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
              tabs: TAB_TITLES.map((String tab) {
                return new Tab(text: tab);
              }).toList()),
        ),
        body: new TabBarView(
          children: buildList(),
        ),
        // drawer: new Drawer(
        //   child: new Text("drawer"),
        // ),
      ),
    );
  }

  List<Widget> buildList() {
    List<Widget> ws = [];
    ws.add(new HomePage());
    for (var i = 1; i < TAB_TITLES.length ; i++) {
      ws.add(new CategoryPage(MOVIE_TYPE[i]));
    }

    return ws;
  }
}
