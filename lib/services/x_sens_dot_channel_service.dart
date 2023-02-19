import 'dart:async';

import 'package:figure_skating_jumps/models/bluetooth_device.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class XSensDotChannelService {
  static const _xSensChannel = MethodChannel('xsens-dot-channel');

  static final XSensDotChannelService _xSensDotChannelService =
  XSensDotChannelService._internal();

  factory XSensDotChannelService() {
    return _xSensDotChannelService;
  }

  XSensDotChannelService._internal();

  Future<String> getSDKVersion() async {
    try {
      return await _xSensChannel.invokeMethod('getSDKVersion');
    } on PlatformException catch (e) {
      return e.message!;
    }
  }

  Future<void> startScan() async {
    try {
      await _xSensChannel.invokeMethod('startScan');
    } on PlatformException catch (e) {
      debugPrint("err");
      debugPrint(e.message!);
    }
  }

  Future<List<BluetoothDevice>> stopScan() async {
    List<Map<String, String>> res = [];
    try {
       res = await _xSensChannel.invokeMethod('stopScan')
      as List<Map<String, String>>;
    } on PlatformException catch (e) {
      debugPrint(e.message!);
    }
    List<BluetoothDevice> devices = [];
    for(var pair in res) {
      devices.add(BluetoothDevice(pair.keys.first, pair.values.first));
    }
    return devices;
  }

  Future<String> connectXSensDot(
      {String macAddress = 'D4:22:CD:00:19:F4'}) async {
    try {
      return await _xSensChannel.invokeMethod(
          'connectXSensDot', <String, dynamic>{'address': macAddress});
    } on PlatformException catch (e) {
      return e.message!;
    }
  }

  Future<String> disconnectXSensDot() async {
    try {
      return await _xSensChannel.invokeMethod('disconnectXSensDot');
    } on PlatformException catch (e) {
      return e.message!;
    }
  }

  startMeasuring() async {
    try {
      debugPrint(await _xSensChannel.invokeMethod('startMeasuring'));
    } on PlatformException catch (e) {
      debugPrint(e.message!);
    }
  }

  stopMeasuring() async {
    try {
      debugPrint(await _xSensChannel.invokeMethod('stopMeasuring'));
    } on PlatformException catch (e) {
      debugPrint(e.message!);
    }
  }
}