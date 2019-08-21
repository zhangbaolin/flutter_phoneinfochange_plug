import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';

import 'package:flutter_phoneinfochange_plug/flutter_phoneinfochange_plug.dart';

class TestPlugpage extends StatefulWidget {
  @override
  _TestPlugpageState createState() => _TestPlugpageState();
}

class _TestPlugpageState extends State<TestPlugpage> {
  int volume = 0;
  int nowVolume = 0;

  int brightness = 0;
  int nowBrightness = 0;

  Future<void> initPlatformState() async {
    try {
      volume = await FlutterPhoneinfochangePlug.getVolume(0);
      setState(() {
        volume = volume;
      });
    } on PlatformException {
      volume = 0;
    }
  }

  Future<void> setVoice() async {
    try {
      nowVolume = await FlutterPhoneinfochangePlug.setVolume(15);
      setState(() {
        nowVolume = nowVolume;
      });
    } on PlatformException {
      nowVolume = 0;
    }
  }

  Future<void> getBrightness() async {
    try {
      brightness = await FlutterPhoneinfochangePlug.getBrightness();
      setState(() {
        brightness = brightness;
      });
    } on PlatformException {
      brightness = 0;
    }
  }

  Future<void> setBrightness() async {
    try {
      nowBrightness = await FlutterPhoneinfochangePlug.setBrightness(50);
      setState(() {
        nowBrightness = nowBrightness;
      });
    } on PlatformException {
      nowBrightness = 0;
    }
  }

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('测试插件'),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: 60,
                alignment: Alignment.center,
                child: Text('系统音量为$volume'),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 60,
                alignment: Alignment.center,
                child: Text('修改后的音量为$nowVolume'),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 60,
                alignment: Alignment.center,
                child: Text('系统的亮度为$brightness'),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 60,
                alignment: Alignment.center,
                child: Text('修改后亮度为$nowBrightness'),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 60,
                alignment: Alignment.center,
                child: MaterialButton(
                  onPressed: () {
                    setVoice();
                  },
                  minWidth: 150,
                  height: 50,
                  color: Colors.lightBlue,
                  child: Text('设置音量'),
                ),
              ),
               Container(
                width: MediaQuery.of(context).size.width,
                height: 60,
                margin: EdgeInsets.only(top: 20),
                alignment: Alignment.center,
                child: MaterialButton(
                  onPressed: () async{
                   getBrightness();
                  },
                  minWidth: 150,
                  height: 50,
                  color: Colors.lightBlue,
                  child: Text('获取亮度'),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 60,
                margin: EdgeInsets.only(top: 20),
                alignment: Alignment.center,
                child: MaterialButton(
                  onPressed: () async{
                   setBrightness();
                  },
                  minWidth: 150,
                  height: 50,
                  color: Colors.lightBlue,
                  child: Text('设置亮度'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
