//
//  AppDelegate.swift
//  estimoteApp
//
//  Created by Alex Cohen on 10/4/17.
//  Copyright © 2017 Alex Cohen. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, ESTMonitoringV2ManagerDelegate {

    var window: UIWindow?
    var monitoringManager: ESTMonitoringV2Manager!



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
                ESTConfig.setupAppID("alexcohen711-gmail-com-s-p-kf6", andAppToken:"eb488b138d9e424ca641aa52b62ece24");

        self.monitoringManager = ESTMonitoringV2Manager(
            desiredMeanTriggerDistance: 1.0, delegate: self)
        self.monitoringManager.startMonitoring(forIdentifiers: [
            "9852034567cbce716349160bac5fa40b",
            "d5e3e955ecc408d84eba997cf6d4053e"])
        
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            print("notifications allowed? = \(granted)")
        }

        // Override point for customization after application launch.
        return true
    }
    
    func monitoringManager(_ manager: ESTMonitoringV2Manager,
                           didEnterDesiredRangeOfBeaconWithIdentifier identifier: String) {
        print("didEnter range of beacon \(identifier)")
        
        showNotification(title: "Hello world", body: "Looks like you're near a beacon.")
    }
    func monitoringManager(_ manager: ESTMonitoringV2Manager,
                           didExitDesiredRangeOfBeaconWithIdentifier identifier: String) {
        print("didExit range of beacon \(identifier)")
        
        showNotification(title: "Goodbye world", body: "You left the proximity of a beacon.")
    }
    
    func showNotification(title: String, body: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = UNNotificationSound.default()
        
        let request = UNNotificationRequest(
            identifier: "BeaconNotification", content: content, trigger: nil)
        let center = UNUserNotificationCenter.current()
        center.add(request, withCompletionHandler: nil)
    }

    
    func monitoringManagerDidStart(_ manager: ESTMonitoringV2Manager) {
        print("monitoringManagerDidStart")
    }
    func monitoringManager(_ manager: ESTMonitoringV2Manager,
                           didFailWithError error: Error) {
        print("monitoringManager didFailWithError: \(error.localizedDescription)")
    }
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

