import 'package:flutter/material.dart';
import 'pages/home.dart';
import 'pages/moveDetail.dart';
import 'package:flutter/rendering.dart';

void main() {
  // debugPaintSizeEnabled = true;
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: "风影院",
        theme: new ThemeData(
          primarySwatch: Colors.grey,
        ),
        initialRoute: "/",
        // home: new MyHomePage(title: "home"),
        routes: {
          "/": (BuildContext context) => new MyHomePage(),
          "/moviedetail": (BuildContext context)=> MovieDetail()
        });
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> tabs = ["首页", "电影", "电视剧", "动漫", "综艺"];
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
    ws.add(new Text("电影"));
    for (var i = 1; i < tabs.length - 1; i++) {
      ws.add(new Text(tabs[i]));
    }
    return ws;
  }
}
