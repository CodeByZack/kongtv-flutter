import 'package:awsome_video_player/awsome_video_player.dart';
import 'package:dlna/dlna.dart';
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
  bool _isfullScreen = false;
  _PlayMovieState(this.arguments);
  var dlnaManager = DLNAManager();
  List<DLNADevice> _devices = [];
  VideoObject _didlObject;
  DLNADevice _dlnaDevice;

  _touPing() async {
    var result = await dlnaManager.actSetVideoUrl(_didlObject);
    print(result);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dlnaManager.setRefresher(DeviceRefresher(onDeviceAdd: (dlnaDevice) {
      if (!_devices.contains(dlnaDevice)) {
        print('add ' + dlnaDevice.toString());
        _devices.add(dlnaDevice);
      }
    }, onDeviceRemove: (dlnaDevice) {
      print('remove ' + dlnaDevice.toString());
    }, onDeviceUpdate: (dlnaDevice) {
      print('update ' + dlnaDevice.toString());
    }, onSearchError: (error) {
      print(error);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _isfullScreen
            ? null
            : AppBar(
                title: Text(
                  "${arguments.movieName}${arguments.linkName}",
                  style: TextStyle(color: Colors.white),
                ),
                iconTheme: IconThemeData(color: Colors.white),
                elevation: 0,
                backgroundColor: arguments.bkColor,
              ),
        body: Container(
          color: arguments.bkColor,
          child: Column(children: [
            Container(
              color: Colors.black,
              child: AwsomeVideoPlayer(
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
                  videoTopBarStyle: VideoTopBarStyle(
                      show: _isfullScreen,
                      contents: [
                        Text(
                          "${arguments.movieName}${arguments.linkName}",
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                      height: 50),

                  /// 自定义底部控制栏
                  videoControlBarStyle: VideoControlBarStyle(
                    playIcon:
                        Icon(Icons.play_arrow, color: Colors.white, size: 16),
                    pauseIcon: Icon(
                      Icons.pause,
                      color: Colors.white,
                      size: 16,
                    ),
                    rewindIcon: Icon(
                      Icons.replay_30,
                      size: 16,
                      color: Colors.white,
                    ),
                    forwardIcon: Icon(
                      Icons.forward_30,
                      size: 16,
                      color: Colors.white,
                    ),
                    fullscreenIcon: Icon(
                      Icons.fullscreen,
                      size: 16,
                      color: Colors.white,
                    ),
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
                onfullscreen: (value) {
                  print(value);
                  setState(() {
                    _isfullScreen = value;
                  });
                },

                /// 顶部控制栏点击返回按钮
                onpop: (value) {
                  print("返回上一页");
                },
              ),
            ),
            RaisedButton(
              child: Text("搜索"),
              onPressed: () {
                // dlnaManager.startSearch();
                showDlnaDialog(context, (callback){print(callback);});
              },
            )
          ]),
        ));
  }

  @override
  void dispose() {
    super.dispose();
    dlnaManager.release();
  }
}

void showDlnaDialog(BuildContext context, Function callback) async {
  var result = await showModalBottomSheet(
    context: context,
    builder: (context) {
      return Container(
        height: 200, //不设置默认高度为一半
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text('分享A'),
              onTap: () {
                Navigator.pop(context, 'A');
              },
            ),
            ListTile(
              title: Text('分享B'),
              onTap: () {
                Navigator.pop(context, 'B');
              },
            ),
            ListTile(
              title: Text('分享C'),
              onTap: () {
                Navigator.pop(context, 'C');
              },
            ),
          ],
        ),
      );
    },
  );
  if(callback!=null){
    callback(result);
  }
}
