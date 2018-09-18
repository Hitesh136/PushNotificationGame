//
//  CustomUserDefault.swift
//  PushNotificationTaster
//
//  Created by Hitesh  Agarwal on 9/14/18.
//  Copyright © 2018 Hitesh  Agarwal. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    static var isAllowedNotification: Bool {
        get {
           return UserDefaults.standard.bool(forKey: "isAllowed")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "isAllowed")
        }
    }
    
    static var pushCount: Int {
        get {
            return UserDefaults.standard.integer(forKey: "Push Count") 
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "Push Count")
        }
    }
    
    static var thumpCount: Int {
        get {
            return UserDefaults.standard.integer(forKey: "Thump Count")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "Thump Count")
        }
    }
}


