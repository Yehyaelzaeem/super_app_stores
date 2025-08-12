
import UIKit
import Flutter
import GoogleMaps // Import Google Maps framework

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // Provide the API key for Google Maps
    GMSServices.provideAPIKey("AIzaSyCcLzjD-Xxomlnw7ALIFCNzp4pQzoAp64Y") // Replace with your actual API key

    // Register plugins
    GeneratedPluginRegistrant.register(with: self)

if #available(iOS 10.0, *) {
  UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
}
    // Return the super method call to continue initialization
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
