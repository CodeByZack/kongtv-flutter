import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:learnflutter/components/homeSection.dart';
import 'package:learnflutter/components/movieItem.dart';
import 'package:learnflutter/http/api.dart';
import 'package:learnflutter/models/movie.dart';
// import 'package:learnflutter/models/movie.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  List<Movie> dy = [];
  List<Movie> zy = [];
  List<Movie> dsj = [];
  List<Movie> dm = [];
  List<Movie> banner = [];

  @override
  bool get wantKeepAlive => true;

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
        if (m.typeId1 == "1") {
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
        banner.add(dyt[0]);
        banner.add(dsjt[0]);
        banner.add(dmt[0]);
        banner.add(zyt[0]);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      // controller: _controller,
      slivers: <Widget>[
        SliverAppBar(
            flexibleSpace: Container(
                height: 250.0,
                child: Swiper(
                  itemBuilder: (BuildContext context, int index) {
                    Movie item = banner[index];
                    return GestureDetector(
                      child: ClipRRect(
                        child: Image.network(
                          item.vodPic,
                          fit: BoxFit.cover,
                        ),
                        // borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      onTap: () {
                        handleTap(context, item);
                      },
                    );
                  },
                  itemCount: banner.length,
                  pagination: SwiperPagination(),
                  // control: SwiperControl(),
                  autoplay: true,
                )),
            expandedHeight: 250,
            automaticallyImplyLeading: false),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              if(index==0)return HomeSection("热播影视", dsj); 
              if(index==1)return HomeSection("热播电影", dy);
              if(index==2)return HomeSection("热播动漫", dm);
              if(index==3)return HomeSection("热播综艺", zy);
              return null;
            },
            childCount: 4,
          ),
        )
      ],
    );
  }

}

