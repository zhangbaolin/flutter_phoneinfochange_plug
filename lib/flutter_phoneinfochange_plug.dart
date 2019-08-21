import 'dart:async';

import 'package:flutter/services.dart';

class FlutterPhoneinfochangePlug {
  static const MethodChannel _channel =
      const MethodChannel('flutter_phoneinfochange_plug');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<int> calculate(int a, int b) async {
    final String result =
        await _channel.invokeMethod('calculate', {'a': a, 'b': b});
    return int.parse(result);
  }

  /*
   *获取音量 
   */
  static Future<int> getVolume(int volume) async {
    final int result =
        await _channel.invokeMethod('getVolume', {'volume': volume});
    return result;
  }

/*
 *设置音量 
 */
  static Future<int> setVolume(int volume) async {
    final int result =
        await _channel.invokeMethod('setVolume', {'volume': volume});
    return result;
  }

/*
 *获取亮度 
 */
  static Future<int> getBrightness() async {
    final int result = await _channel.invokeMethod('getBrightness');
    return result;
  }

/*
 *设置手机亮度 
 */

  static Future<int> setBrightness(int brightness) async {
    final int result = await _channel
        .invokeMethod('setBrightness', {'brightness': brightness});
    return result;
  }
}
