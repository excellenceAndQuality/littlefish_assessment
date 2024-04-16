import Flutter
import UIKit
import SystemConfiguration

public class SwiftConnectivityPlugin: NSObject, FlutterPlugin, FlutterStreamHandler {

    private var reachability: SCNetworkReachability?
    private var connectivityCallback: FlutterEventSink?

    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "connectivity_plugin", binaryMessenger: registrar.messenger())
        let eventChannel = FlutterEventChannel(name: "connectivity_plugin/changes", binaryMessenger: registrar.messenger())
        let instance = SwiftConnectivityPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
        eventChannel.setStreamHandler(instance)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "isConnected":
            result(isConnected())
        default:
            result(FlutterMethodNotImplemented)
        }
    }

    public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        connectivityCallback = events
        startMonitoring()
        return nil
    }

    public func onCancel(withArguments arguments: Any?) -> FlutterError? {
        stopMonitoring()
        connectivityCallback = nil
        return nil
    }

    private func isConnected() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)

        guard let reachability = SCNetworkReachabilityCreateWithAddress(nil, &zeroAddress) else {
            return false
        }

        var flags: SCNetworkReachabilityFlags = []
        guard SCNetworkReachabilityGetFlags(reachability, &flags) else {
            return false
        }

        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        return isReachable && !needsConnection
    }

    private func startMonitoring() {
        if reachability == nil {
            var zeroAddress = sockaddr_in()
            zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
            zeroAddress.sin_family = sa_family_t(AF_INET)
            reachability = SCNetworkReachabilityCreateWithAddress(nil, &zeroAddress)
        }

        var context = SCNetworkReachabilityContext(
            version: 0,
            info: UnsafeMutableRawPointer(Unmanaged<SwiftConnectivityPlugin>.passUnretained(self).toOpaque()),
            retain: nil,
            release: nil,
            copyDescription: nil)

        SCNetworkReachabilitySetCallback(reachability, { _, flags, info in
            guard let info = info else { return }
            let plugin = Unmanaged<SwiftConnectivityPlugin>.fromOpaque(info).takeUnretainedValue()
            let isConnected = flags.contains(.reachable) && !flags.contains(.connectionRequired)
            plugin.connectivityCallback?(isConnected)
        }, &context)

        SCNetworkReachabilitySetDispatchQueue(reachability, DispatchQueue.main)
    }

    private func stopMonitoring() {
        if let reachability = reachability {
            SCNetworkReachabilitySetDispatchQueue(reachability, nil)
        }
    }
}
