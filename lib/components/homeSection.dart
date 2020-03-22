
import 'package:flutter/material.dart';
import 'package:learnflutter/models/movie.dart';

import 'movieItem.dart';

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
        buildSectionTitle(),
        GridView.count(
            crossAxisCount: 3,
            childAspectRatio: 2 / 3.6,
            shrinkWrap: true,
            crossAxisSpacing: 10,
            padding: EdgeInsets.symmetric(horizontal: 10),
            physics: NeverScrollableScrollPhysics(),
            children: buildGrid(context, movies))
      ],
    );
  }

  Container buildSectionTitle() {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(color: Colors.grey[200], width: 1))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: Text(title,
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.bold)),
            padding: EdgeInsets.only(left: 8.0),
            decoration: BoxDecoration(
                border:
                    Border(left: BorderSide(color: Colors.black87, width: 4))),
          ),
          Text(
            "更多>",
            style: TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  List<Widget> buildGrid(BuildContext context, List<Movie> arry) {
    return arry.map((item) {
      return MovieItem(context, item);
    }).toList();
  }
}