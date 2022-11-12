import Flutter
import UIKit

public class SwiftSurrealdbPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "surrealdb", binaryMessenger: registrar.messenger())
    let instance = SwiftSurrealdbPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }

  public func dummyMethodToEnforceBundling() {
      // dummy calls to prevent tree shaking
      rust_greeting("");
  }
}
