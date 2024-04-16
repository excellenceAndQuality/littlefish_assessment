// You have generated a new plugin project without specifying the `--platforms`
// flag. A plugin project with no platform support was generated. To add a
// platform, run `flutter create -t plugin --platforms <platforms> .` under the
// same directory. You can also find a detailed instruction on how to add
// platforms in the `pubspec.yaml` at
// https://flutter.dev/docs/development/packages-and-plugins/developing-packages#plugin-platforms.

import 'connectivity_plugin_platform_interface.dart';
import 'dart:async';
import 'package:flutter/services.dart';

class ConnectivityPlugin {
  Future<String?> getPlatformVersion() {
    return ConnectivityPluginPlatform.instance.getPlatformVersion();
  }

  static const MethodChannel _channel = MethodChannel('connectivity_plugin');
  static const EventChannel _eventChannel = EventChannel('connectivity_plugin/changes');

  // Method to check internet connectivity
  static Future<bool> isConnected() async {
    final bool isConnected = await _channel.invokeMethod('isConnected');
    return isConnected;
  }

  // Event stream to notify when connectivity status changes
  static Stream<bool> get onConnectivityChanged {
    return _eventChannel
        .receiveBroadcastStream()
        .map((event) => event as bool);
  }
}
