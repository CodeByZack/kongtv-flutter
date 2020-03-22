import 'package:flutter/material.dart';

AppBar buildAppBar(String title, List<String> tabs) {
  return AppBar(
      title: new Container(
        // color: Colors.grey[400].withOpacity(0.5),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "电影名称/关键词",
                style: TextStyle(color: Colors.grey[700],fontSize: 14),
              ),
              Icon(Icons.search)
            ]),
        padding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 4.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            color: Colors.grey[300].withOpacity(0.5)),
      ),
      elevation: 0,
      titleSpacing: 0,
      actions: <Widget>[
        IconButton(
          icon: new Icon(Icons.share),
          tooltip: "search",
          onPressed: ()=>{},
        )
      ],
      bottom: TabBar(tabs: tabs.map((String tab) => Tab(text: tab)).toList()));
}
