import 'package:flutter/material.dart';
import 'package:learnflutter/models/movie.dart';

Widget MovieItem(BuildContext context, Movie item) {
  return GestureDetector(
      onTap: () {
        handleTap(context, item);
      },
      child: Container(
          margin: EdgeInsets.only(bottom: 16),
          child: Material(
            color: Colors.white,
            elevation: 5,
            borderRadius: BorderRadius.all(Radius.circular(8)),
            child: Column(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8)),
                  child: Hero(
                    child: AspectRatio(
                      aspectRatio: 9 / 12,
                      child: Image.network(
                        item.vodPic,
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter,
                      ),
                    ),
                    tag: item.vodId,
                  ),
                ),
                Padding(
                    child: Text(
                      item.vodName,
                      overflow: TextOverflow.ellipsis,
                    ),
                    padding: EdgeInsets.only(top: 8))
              ],
            ),
          )));
}

handleTap(BuildContext context, Movie item) {
  print(item.vodName);
  Navigator.of(context).pushNamed("/moviedetail", arguments: item);
}
