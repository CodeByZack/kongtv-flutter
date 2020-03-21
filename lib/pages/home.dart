import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:learnflutter/http/api.dart';
import 'package:learnflutter/models/movie.dart';
// import 'package:learnflutter/models/movie.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Movie> dy = [];
  List<Movie> zy = [];
  List<Movie> dsj = [];
  List<Movie> dm = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getHttp().then((onValue) {
      var movies = json.decode(onValue.data);
      movies = movies.map((item) {
        return Movie.fromJson(item);
      }).toList();
      List<Movie> dyt = List(), dmt = List(), dsjt = List(), zyt = List();
      for (var i = 0; i < movies.length; i++) {
        Movie m = movies[i];
        if (m.typeId1== "1") {
          dyt.add(m);
        } else if (m.typeId1 == "2") {
          dsjt.add(m);
        } else if (m.typeId == "3") {
          dmt.add(m);
        } else if (m.typeId == "4") {
          zyt.add(m);
        }
      }
      print(dyt.length);
      print(dmt.length);
      print(dsjt.length);
      print(zyt.length);

      setState(() {
        dy = dyt;
        dsj = dsjt;
        dm = dmt;
        zy = zyt;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new ListView(
      children: <Widget>[
        new Container(
          height: 200.0, // 单位是逻辑上的像素（并非真实的像素，类似于浏览器中的像素）
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          decoration: new BoxDecoration(color: Colors.blue[500]),
        ),
        new HomeSection("热播影视", dsj),
        new HomeSection("热播电影", dy),
        new HomeSection("热播动漫", dm),
        new HomeSection("热播综艺", zy),
      ],
    );
  }
}

class HomeSection extends StatelessWidget {
  List<Movie> movies;
  String title;
  HomeSection(
    String title,
    List<Movie> movies,
  ) {
    this.movies = movies;
    this.title = title;
  }
  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            children: <Widget>[
              Padding(
                child: Icon(Icons.favorite),
                padding: EdgeInsets.only(right: 8),
              ),
              Text(title,
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        GridView.count(
            crossAxisCount: 3,
            childAspectRatio: 2 / 3.5,
            shrinkWrap: true,
            crossAxisSpacing: 10,
            padding: EdgeInsets.symmetric(horizontal: 10),
            physics: NeverScrollableScrollPhysics(),
            children: buildGrid(context,movies))
      ],
    );
  }

  List<Widget> buildGrid(BuildContext context,List<Movie> arry) {
    return arry.map((item) {
      return GestureDetector(
          onTap: (){handleTap(context,item);},
          child: Column(
            children: <Widget>[
              Image.network(
                item.vodPic,
                fit: BoxFit.cover,
                height: 160,
              ),
              Padding(
                  child: Text(
                    item.vodName,
                    overflow: TextOverflow.ellipsis,
                  ),
                  padding: EdgeInsets.only(top: 10))
            ],
          ));
    }).toList();
  }

  handleTap(BuildContext context,Movie item) {
    print(item.vodName);
    Navigator.of(context).pushNamed("/moviedetail",arguments: item);
  }
}
