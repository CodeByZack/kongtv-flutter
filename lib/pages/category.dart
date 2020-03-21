import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:learnflutter/base/basePage.dart';
import 'package:learnflutter/http/api.dart';
import 'package:learnflutter/models/movie.dart';
import 'package:learnflutter/pages/components/movieItem.dart';

class CategoryPage extends StatefulWidget {
  String type;
  CategoryPage(this.type);
  @override
  _CategoryPage createState() => new _CategoryPage(type);
}

class _CategoryPage extends State<CategoryPage> with CancelMixin {
  int page = 0;
  int loadStatus = 0;
  String type;
  List<Movie> data = [];
  //初始化滚动监听器，加载更多使用
  ScrollController _controller = new ScrollController();

  _CategoryPage(this.type);

  loadMoreData() async {
    this.page++;
    setState(() {
      loadStatus = 1; //加载中;
    });
    var token = CancelToken();
    // 在widget释放时候执行
    addToDispose(() {
      token.cancel();
    });
    Response response = await getCatagory(this.type, this.page);
    var movies = json.decode(response.data);
    List<Movie> dataNew = (movies as List).map((item) {
      return Movie.fromJson(item);
    }).toList();

    if (dataNew.length == 0) {
      setState(() {
        loadStatus = 2; //没有更多
      });
      return;
    }
    setState(() {
      loadStatus = 0; //正常状态
      data.addAll(dataNew);
    });
  }

  List<Widget> buildList(
      BuildContext context, List<Movie> arry, int loadStatus) {
    List<Widget> movies = arry.map((item) {
      return MovieItem(context, item);
    }).toList();

    if (loadStatus == 1) {
      movies.add(GestureDetector(child: new Text("加载中。。。")));
    } else if (loadStatus == 2) {
      movies.add(GestureDetector(child: new Text("没有更多。。。")));
    }
    return movies;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //固定写法，初始化滚动监听器，加载更多使用
    _controller.addListener(() {
      var maxScroll = _controller.position.maxScrollExtent;
      var pixel = _controller.position.pixels;
      if (maxScroll == pixel && loadStatus != 2) {
        print("loadmoer");
        loadMoreData();
      }
    });
    loadMoreData();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print("rnder:$type");
    return Padding(
      padding: EdgeInsets.all(10),
      child: GridView.count(
          crossAxisCount: 3,
          childAspectRatio: 2 / 3.5,
          shrinkWrap: true,
          crossAxisSpacing: 10,
          controller: _controller,
          // padding: EdgeInsets.symmetric(horizontal: 10),
          children: buildList(context, data, loadStatus)),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
