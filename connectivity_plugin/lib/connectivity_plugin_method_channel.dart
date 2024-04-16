import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'connectivity_plugin_platform_interface.dart';

/// An implementation of [ConnectivityPluginPlatform] that uses method channels.
class MethodChannelConnectivityPlugin extends ConnectivityPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('connectivity_plugin');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
