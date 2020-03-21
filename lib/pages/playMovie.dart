import 'package:awsome_video_player/awsome_video_player.dart';
import 'package:flutter/material.dart';
import 'package:learnflutter/pages/moveDetail.dart';

class PlayMovie extends StatefulWidget {
  Object arguments;
  PlayMovie(this.arguments);
  @override
  _PlayMovieState createState() => new _PlayMovieState(arguments);
}

class _PlayMovieState extends State<PlayMovie> {
  PlayItem arguments;

  _PlayMovieState(this.arguments);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          title: Text("${arguments.movieName}${arguments.linkName}"),
        ),
        body: Column(
          children: [AwsomeVideoPlayer(
            arguments.linkUrl,
            /// 视频播放配置
            playOptions: VideoPlayOptions(
                seekSeconds: 30,
                aspectRatio: 16 / 9,
                loop: true,
                autoplay: true,
                allowScrubbing: true,
                startPosition: Duration(seconds: 0)),

            /// 自定义视频样式
            videoStyle: VideoStyle(
              /// 自定义视频暂停时视频中部的播放按钮
              playIcon: Icon(
                Icons.play_circle_outline,
                size: 50,
                color: Colors.white,
              ),

              /// 暂停时是否显示视频中部播放按钮
              showPlayIcon: true,

              /// 自定义底部控制栏
              videoControlBarStyle: VideoControlBarStyle(
                /// 自定义颜色
                //barBackgroundColor: Colors.blue,
                /// 自定义进度条样式
                progressStyle: VideoProgressStyle(
                    // padding: EdgeInsets.all(0),
                    // playedColor: Colors.red,
                    // bufferedColor: Colors.yellow,
                    // backgroundColor: Colors.green,
                    dragBarColor:
                        Colors.white, //进度条为`progress`时有效，如果时`basic-progress`则无效
                    height: 4,
                    progressRadius:
                        2, //进度条为`progress`时有效，如果时`basic-progress`则无效
                    dragHeight: 5 //进度条为`progress`时有效，如果时`basic-progress`则无效
                    ),

                /// 更改进度栏的播放按钮
                playIcon: Icon(Icons.play_arrow, color: Colors.white, size: 16),

                /// 更改进度栏的暂停按钮
                pauseIcon: Icon(
                  Icons.pause,
                  color: Colors.white,
                  size: 16,
                ),

                /// 更改进度栏的快退按钮
                rewindIcon: Icon(
                  Icons.replay_30,
                  size: 16,
                  color: Colors.white,
                ),

                /// 更改进度栏的快进按钮
                forwardIcon: Icon(
                  Icons.forward_30,
                  size: 16,
                  color: Colors.white,
                ),

                /// 更改进度栏的全屏按钮
                fullscreenIcon: Icon(
                  Icons.fullscreen,
                  size: 16,
                  color: Colors.white,
                ),

                /// 更改进度栏的退出全屏按钮
                fullscreenExitIcon: Icon(
                  Icons.fullscreen_exit,
                  size: 16,
                  color: Colors.red,
                ),

                /// 决定控制栏的元素以及排序，示例见上方图3
                itemList: [
                  "rewind",
                  "play",
                  "forward",
                  "position-time", //当前播放时间
                  "progress", //线形进度条
                  //"basic-progress",//矩形进度条
                  "duration-time", //视频总时长
                  // "time", //格式：当前时间/视频总时长
                  "fullscreen"
                ],
              ),
            ),

            /// 网络变化回调
            onnetwork: (value) {
              print("onbrightness $value");
            },

            /// 顶部控制栏点击返回按钮
            onpop: (value) {
              print("返回上一页");
            },
          ),
          ]
        ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
