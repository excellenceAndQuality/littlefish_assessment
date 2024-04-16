import 'package:flutter_test/flutter_test.dart';
import 'package:connectivity_plugin/connectivity_plugin.dart';
import 'package:connectivity_plugin/connectivity_plugin_platform_interface.dart';
import 'package:connectivity_plugin/connectivity_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockConnectivityPluginPlatform
    with MockPlatformInterfaceMixin
    implements ConnectivityPluginPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final ConnectivityPluginPlatform initialPlatform = ConnectivityPluginPlatform.instance;

  test('$MethodChannelConnectivityPlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelConnectivityPlugin>());
  });

  test('getPlatformVersion', () async {
    ConnectivityPlugin connectivityPlugin = ConnectivityPlugin();
    MockConnectivityPluginPlatform fakePlatform = MockConnectivityPluginPlatform();
    ConnectivityPluginPlatform.instance = fakePlatform;

    expect(await connectivityPlugin.getPlatformVersion(), '42');
  });
}
