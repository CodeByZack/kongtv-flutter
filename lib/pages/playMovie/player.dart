import 'package:awsome_video_player/awsome_video_player.dart';
import 'package:flutter/material.dart';

Widget buildPlayer(_isfullScreen, linkUrl, title, onfullscreen) {
  return Container(
    color: Colors.black,
    child: AwsomeVideoPlayer(
      linkUrl,

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
                title,
                style: TextStyle(color: Colors.white),
              )
            ],
            height: 50),

        /// 自定义底部控制栏
        videoControlBarStyle: VideoControlBarStyle(
          playIcon: Icon(Icons.play_arrow, color: Colors.white, size: 16),
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
      onfullscreen: onfullscreen,
    ),
  );
}
