import 'package:flutter/material.dart';
import 'package:learnflutter/models/movie.dart';
import 'package:color_thief_flutter/color_thief_flutter.dart';
import 'package:color_thief_flutter/utils.dart';

class MovieDetail extends StatefulWidget {
  Movie arg;
  MovieDetail(this.arg);
  @override
  _MovieDetailState createState() => new _MovieDetailState(arg);
}

class _MovieDetailState extends State<MovieDetail> {
  TextStyle _textStyle = TextStyle(
    color: Colors.white.withOpacity(0.8),
    fontSize: 14,
  );
  BoxDecoration _decoration = BoxDecoration(
      color: Colors.white60.withOpacity(0.2),
      borderRadius: BorderRadius.circular(4));
  Color bkColor = Colors.grey;
  Movie item;
  _MovieDetailState(this.item);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPaletteFromUrl(item.vodPic).then((colors) {
      print(colors);
      var color = colors[4];
      if (color != null) {
        setState(() {
          bkColor = Color.fromRGBO(color[0], color[1], color[2], 1);
        });
      }
    }).catchError(
        (onError) => {print("onError:ssssssssssssssssssssssssssssss")});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(item.vodName, style: TextStyle(color: Colors.white)),
          backgroundColor: bkColor,
          iconTheme: IconThemeData(color: Colors.white),
          elevation: 0,
        ),
        body: Container(
          height: double.infinity,
          color: bkColor,
          child: SingleChildScrollView(
            child: Column(children: <Widget>[
              buildTop(item),
              buildDesc(item),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: buildPlayList(context, item),
              )
            ]),
            padding: EdgeInsets.all(16),
          ),
        ));
  }

  Row buildTop(Movie item) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
            flex: 1,
            child: Container(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: AspectRatio(
                  aspectRatio: 9 / 12,
                  child: Image.network(item.vodPic, fit: BoxFit.cover),
                ),
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 1)]),
            )),
        Expanded(
          flex: 2,
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  item.vodName,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "别名: ${item.vodName}",
                  style: _textStyle,
                ),
                Text(
                  "导演: ${item.vodDirector}",
                  style: _textStyle,
                ),
                Text(
                  "主演: ${item.vodActor}",
                  style: _textStyle,
                ),
                Text(
                  "类型: ${item.vodClass}",
                  style: _textStyle,
                ),
                Text(
                  "地区: ${item.vodArea}",
                  style: _textStyle,
                ),
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
      padding: EdgeInsets.all(8),
      decoration: _decoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "简介：",
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          Text(
            item.vodContent,
            style: _textStyle,
          )
        ],
      ),
    );
  }

  Column buildPlayList(BuildContext context, Movie item) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(
              Icons.list,
              size: 20,
              color: Colors.white,
            ),
            Text(
              "剧集列表",
              style: TextStyle(color: Colors.white, fontSize: 16),
            )
          ],
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
      widgets.add(GestureDetector(
        onTap: () {
          print(play);
          Navigator.pushNamed(context, "/playmovie", arguments: play);
        },
        child: Container(
          decoration: _decoration,
          alignment: Alignment.center,
          child: Text(
            play.linkName,
            style: _textStyle,
          ),
        ),
      ));
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
