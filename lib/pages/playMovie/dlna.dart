import 'dart:async';

import 'package:dlna/dlna.dart';
import 'package:flutter/material.dart';

Future showDlnaDialog(BuildContext context,title,url) async {
  var result = await showModalBottomSheet(
      context: context,
      isDismissible: false,
      backgroundColor: Colors.transparent,
      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      builder: (context) {
        return DlnaList(title,url);
      });
  print(result);
  return result;
}

class DlnaList extends StatefulWidget {
  String title,url;
  DlnaList(this.title,this.url);
  @override
  State<StatefulWidget> createState() => DlnaListState();
}

class DlnaListState extends State<DlnaList> {
  DLNAManager dlnaManager = DLNAManager();
  List<DLNADevice> _devices = [];
  int nowChoose;
  VideoObject _didlObject;
  DLNADevice _dlnaDevice;
  Timer timer;
  @override
  void initState() {
    super.initState();
    print("initstate");
    dlnaManager.setRefresher(DeviceRefresher(
      onDeviceAdd: (device) {
      print("device found!");
      if (!_devices.contains(device)) {
        _devices.add(device);
      }
    },
    onSearchError: (msg){
      print(msg);
    }
    ));
    dlnaManager.startSearch();
  }

  @override
  void dispose() {
    super.dispose();
    dlnaManager.stopSearch();
    dlnaManager.release();
    dlnaManager = null;
    if (timer != null) timer.cancel();
  }

  _touPing(device) async{
    var didlObject = VideoObject(widget.title, widget.url, "http-get:*:*/*");
    dlnaManager.setDevice(device);
    await dlnaManager.actSetVideoUrl(didlObject);
  }

  List<Widget> _buildDeviceList() {
    List<Widget> widgets = [];

    _devices.forEach((device) {
      var t = ListTile(
        title: Text(device.deviceName),
        onTap: () {
          _touPing(device);
          setState(() {
            _dlnaDevice = device;
          });
        },
        trailing: _dlnaDevice == device ? Icon(Icons.check) : null,
      );
      widgets.add(t);
    });

    // widgets.add();
    return ListTile.divideTiles(tiles: widgets, color: Colors.grey[300])
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: <Widget>[
          Expanded(
              flex: 1,
              child: _devices.length == 0
                  ? Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                      child: Column(
                        children: _buildDeviceList(),
                      ),
                    )),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
                border: Border(top: BorderSide(color: Colors.grey[300]))),
            child: FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("收起")),
          )
        ],
      ),
    );
  }
}
