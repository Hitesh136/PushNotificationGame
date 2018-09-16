//
//  AppDelegate.swift
//  PushNotificationTaster
//
//  Created by Hitesh  Agarwal on 9/13/18.
//  Copyright © 2018 Hitesh  Agarwal. All rights reserved.
//

import UIKit
import CoreData 
import UserNotifications
import SafariServices

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var viewActionIdentifier = "ViewActionIdentifier"
    var viewCategorieIdemtifier = "VIEW"
    
    let openURLIdentifier = "openURLIdentifier"
    let openURLCategory = "OPEN_URL"
    
    let ignoreActionIdentifier = "ignoreActionIdentifier"
    let ignoreURLCategory = "ignoreActionCatagory"
    
    let thumpsUpAction = "Thumps up Action"
    let thumpsUPCategory = "Thumps up catagory"

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
       
        //Check if launch by notification tap
       
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { ( granted, error) in
            guard granted else {
                myLog("Notification Authorization not granted")
                return
            }
            myLog("Notification Authorization granted")
            
            //Category View
            let viewAction = UNNotificationAction(identifier: self.viewActionIdentifier, title: "View", options: [.foreground])
            let viewCatagories = UNNotificationCategory(identifier: self.viewCategorieIdemtifier, actions: [viewAction], intentIdentifiers: [], options: [])
            
            //Category Open URL
            let openURLAction = UNNotificationAction(identifier: self.openURLIdentifier, title: "Open URL 🧐", options: [.foreground])
            let openURLCategory = UNNotificationCategory(identifier: self.viewCategorieIdemtifier, actions: [openURLAction], intentIdentifiers: [], options: [])
            
            //Category Thumps up
            let thumpsUPAction = UNNotificationAction(identifier: self.thumpsUpAction, title: "👍👍", options: [.foreground])
            let thumpsUpCatagory = UNNotificationCategory(identifier: self.viewCategorieIdemtifier, actions: [thumpsUPAction], intentIdentifiers: [], options: [])
            
            //Catagory Igonre
            let ignoreAction = UNNotificationAction(identifier: self.ignoreActionIdentifier, title: "Ignore 😡😡", options: [.destructive])
            let ignoreCatagory = UNNotificationCategory(identifier: self.viewCategorieIdemtifier, actions: [ignoreAction], intentIdentifiers: [], options: [])
            
            UNUserNotificationCenter.current().setNotificationCategories([viewCatagories, openURLCategory, thumpsUpCatagory, ignoreCatagory])
            self.getNotificationSetting()
        }
        return true
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        myLog(userInfo)
       if let absDict = userInfo["aps"] as? [String: Any] {
        if let _ = absDict["content-available"] as? Int {
            UserDefaults.pushCount = UserDefaults.pushCount + 1
            if let navc = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController, let rootViewController = navc.viewControllers.first as? ViewController {
                rootViewController.setPushNotificationData()
            }
        }
        else if let message = absDict["alert"] as? String {
                myLog(message)
                if let customAlertController = CustomAlertController.create(title: message, subtitle: "") {
                    if let navc = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController, let rootViewController = navc.viewControllers.first {
                        rootViewController.navigationController?.pushViewController(customAlertController, animated: true)
                    }
                }
            }
        }
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        if let navc = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController, let rootViewController = navc.viewControllers.first as? ViewController {
            rootViewController.setPushNotificationData()
        }
    }
    
    //Register for device token
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        myLog("Device Token \(deviceToken)")
        let tokenParts = deviceToken.map { data -> String in
            return String(format: "%02.2hhx", data)
        }
        
        let token = tokenParts.joined()
        myLog("Device Token: \(token)")
    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        myLog("Can't register for PUSH Notifications.")
    }
}

//MARK:- Helper Methods
extension AppDelegate {
    func getNotificationSetting() {
        UNUserNotificationCenter.current().getNotificationSettings { (notificationSetting) in
            myLog("Notification Setting \(notificationSetting)")
            
            guard notificationSetting.authorizationStatus == .authorized else {
                return
            }
            
            DispatchQueue.main.async {
                print("Registering for notification")
                UIApplication.shared.registerForRemoteNotifications()
                
            }
        }
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        let userInfo = response.notification.request.content.userInfo
        guard let apsDict = userInfo["aps"] as? [String: AnyObject] else {
            return
        }
        
        guard let link = apsDict["url"] as? String, let url = URL(string: link) else {
            return
        }
        
        guard response.actionIdentifier == viewActionIdentifier else {
            return
        }
        
        let webViewController = SFSafariViewController(url: url)
        if let navc = window?.rootViewController as? UINavigationController, let viewController = navc.viewControllers.first as? ViewController {
            
            viewController.navigationController?.pushViewController(webViewController, animated: true)
        }
    }
}


