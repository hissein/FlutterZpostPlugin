import 'dart:async';
import 'package:flutter/services.dart';

class ZpostCliv2 {
  static const MethodChannel _channel = const MethodChannel('ZpostCliv2');

  static Future<bool> initSdk() async {
    bool init = false;
    try {
      init = await _channel.invokeMethod('initSdk');
    } catch (e) {
      throw e;
    }
    return init;
  }

  static Future<bool> printTicket(String file) async {
    Map<String, String> files = <String, String>{};
    files.putIfAbsent("file", () => file);
    bool init = false;
    try {
      init = await _channel.invokeMethod('printTicket', files);
    } catch (e) {
      throw e;
    }
    return init;
  }
}
