import 'package:flutter/material.dart';
import 'package:learnflutter/models/movie.dart';

class MovieDetail extends StatefulWidget {
  @override
  _MovieDetailState createState() => new _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  @override
  Widget build(BuildContext context) {
    Movie item = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(item.vodName),
        elevation: 0,
      ),
      body: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 16),
            child: Column(children: <Widget>[
              buildTop(item),
              buildDesc(item),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: buildPlayList(context, item),
              )
            ]),
          )),
    );
  }

  Row buildTop(Movie item) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Image.network(item.vodPic),
        ),
        Expanded(
          flex: 2,
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(item.vodName),
                Text("别名: ${item.vodName}"),
                Text("导演: ${item.vodDirector}"),
                Text("主演: ${item.vodActor}"),
                Text("类型: ${item.vodClass}"),
                Text("地区: ${item.vodArea}"),
              ],
            ),
            margin: EdgeInsets.only(left: 16),
          ),
        ),
      ],
    );
  }

  Container buildDesc(Movie item) {
    return Container(
      margin: EdgeInsets.only(top: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "简介：",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Text(item.vodContent)
        ],
      ),
    );
  }

  Column buildPlayList(BuildContext context, Movie item) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[Icon(Icons.list), Text("剧集列表")],
        ),
        GridView.count(
          crossAxisCount: 4,
          childAspectRatio: 2 / 0.7,
          shrinkWrap: true,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          padding: EdgeInsets.only(top: 10),
          physics: NeverScrollableScrollPhysics(),
          children: handlePlayList(context, item),
        )
      ],
    );
  }

  List<Widget> handlePlayList(BuildContext context, Movie item) {
    String url = item.vodPlayUrl;
    List<String> t = url.split("\$\$\$");
    String one = t[0];
    t = one.split("#");
    List<PlayItem> list = [];

    t.forEach((e) {
      List<String> tt = e.split("\$");
      PlayItem playItem = new PlayItem(item.vodName, tt[0], tt[1]);
      list.add(playItem);
    });

    List<Widget> widgets = [];

    list.forEach((play) {
      widgets.add(RaisedButton(
          onPressed: () {
            print(play);
            Navigator.pushNamed(context, "/playmovie", arguments: play);
          },
          textColor: Colors.white,
          color: Color.fromARGB(2, 2, 200, 200),
          padding: const EdgeInsets.all(0.0),
          child: Text(play.linkName)));
    });

    return widgets;
  }
}

class PlayItem {
  String movieName;
  String linkName;
  String linkUrl;
  PlayItem(this.movieName, this.linkName, this.linkUrl);
}
