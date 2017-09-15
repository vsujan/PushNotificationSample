//
//  AppDelegate.swift
//  PushNotificationSample
//
//  Created by Sujan Vaidya on 9/14/17.
//  Copyright © 2017 Sujan Vaidya. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  var fromLaunch = false
  
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    if #available(iOS 10.0, *) {
      let mynotif = UNUserNotificationCenter.current()
      mynotif.requestAuthorization(options: [.alert, .sound, .badge]) {(granted, error) in
        guard granted else { return }
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
          print("Notification settings: \(settings)")
          guard settings.authorizationStatus == .authorized else { return }
          UIApplication.shared.registerForRemoteNotifications()
        }
      }
    } else {
      // Fallback on earlier versions
      UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil))
      UIApplication.shared.registerForRemoteNotifications()
      //      UIApplication.shared.register
    }
    
    //sujan-note When the app is in close state
    if let _ = launchOptions?[.remoteNotification] as? [String: AnyObject] {
      fromLaunch = true
    }
    
    return true
  }
  
  func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    //    let tokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
    let tokenString = deviceToken.reduce("") { string, byte in
      string + String(format: "%02X", byte)
    }
    print("Device Token: \(tokenString)")
  }
  
  func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
    print("Failed to register: \(error)")
  }
  
  func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
    //sujan-note When the app is in foreground or background
    
    //    let aps = userInfo["aps"] as! [String: AnyObject]
    //    print(aps)
    
    let text = fromLaunch ? "From did launch" : "From did receive"
    fromLaunch = false
    
    let alert = UIAlertController(title: "Simple", message: text, preferredStyle: .alert)
    
    alert.addAction(UIAlertAction(title: "Destructive", style: .destructive) { _ in
      print("Destructive")
    })
    alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
      print("OK")
    })
    
    self.window?.rootViewController?.present(alert, animated: true, completion: nil)
    
  }
  
}
