
import 'package:flutter/material.dart';
import 'package:learnflutter/pages/moveDetail.dart';
import 'package:learnflutter/pages/playMovie/player.dart';
import 'dlna.dart';

class PlayMovie extends StatefulWidget {
  PlayItem playItem;
  PlayMovie(this.playItem);
  @override
  _PlayMovieState createState() => new _PlayMovieState();
}

class _PlayMovieState extends State<PlayMovie> {
  bool _isfullScreen = false;

  @override
  void initState() {
    super.initState();
  }

  _buildAppbar(_isfullScreen, title, bkColor) {
    if (_isfullScreen) return null;

    return AppBar(
      title: Text(
        title,
        style: TextStyle(color: Colors.white),
      ),
      iconTheme: IconThemeData(color: Colors.white),
      elevation: 0,
      backgroundColor: bkColor,
    );
  }

  onfullscreen(value){
    print(value);
    setState(() {
      _isfullScreen = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final movieName = widget.playItem.movieName;
    final linkName = widget.playItem.linkName;
    final linkUrl = widget.playItem.linkUrl;
    final bkColor = widget.playItem.bkColor;

    final title = "${movieName}${linkName}";

    return Scaffold(
        appBar:_buildAppbar(_isfullScreen,title,bkColor),
        body: Container(
          color: bkColor,
          child: Column(children: [
            buildPlayer(_isfullScreen, linkUrl, title, onfullscreen),
            RaisedButton(
              child: Text("搜索"),
              onPressed: () {
                showDlnaDialog(context,title,linkUrl);
              },
            )
          ]),
        ));
  }
}
