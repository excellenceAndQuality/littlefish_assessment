import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'connectivity_plugin_method_channel.dart';

abstract class ConnectivityPluginPlatform extends PlatformInterface {
  /// Constructs a ConnectivityPluginPlatform.
  ConnectivityPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static ConnectivityPluginPlatform _instance = MethodChannelConnectivityPlugin();

  /// The default instance of [ConnectivityPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelConnectivityPlugin].
  static ConnectivityPluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [ConnectivityPluginPlatform] when
  /// they register themselves.
  static set instance(ConnectivityPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
