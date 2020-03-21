import 'package:flutter/material.dart';
import 'package:learnflutter/models/movie.dart';

Widget MovieItem(BuildContext context, Movie item) {
  return GestureDetector(
    onTap: () {
      handleTap(context, item);
    },
    child: Container(
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8), topRight: Radius.circular(8)),
              child: AspectRatio(
                aspectRatio: 9 / 12,
                child: Image.network(
                  item.vodPic,
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                ),
              ),
            ),
            Padding(
                child: Text(
                  item.vodName,
                  overflow: TextOverflow.ellipsis,
                ),
                padding: EdgeInsets.only(top: 10))
          ],
        ),
        decoration: new BoxDecoration(
            color: Colors.white,
            borderRadius: new BorderRadius.all(new Radius.circular(8.0)),
            boxShadow: [
              ///阴影颜色/位置/大小等
              BoxShadow(
                color: Colors.grey[300], offset: Offset(1, 1),
                ///模糊阴影半径
                blurRadius: 5,
              )
            ]),
        margin: const EdgeInsets.only(bottom: 15)),
  );
}

handleTap(BuildContext context, Movie item) {
  print(item.vodName);
  Navigator.of(context).pushNamed("/moviedetail", arguments: item);
}
