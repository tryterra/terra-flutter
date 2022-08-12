import UIKit
import Flutter
import TerraiOS

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
      Terra.setUpBackgroundDelivery()
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
