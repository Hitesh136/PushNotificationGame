//
//  NotificationViewController.swift
//  NotificationExtension
//
//  Created by Hitesh  Agarwal on 9/19/18.
//  Copyright © 2018 Hitesh  Agarwal. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI

class NotificationViewController: UIViewController, UNNotificationContentExtension {

    @IBOutlet var label: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any required interface initialization here.
    }
    
    func didReceive(_ notification: UNNotification) {
        self.label?.text = notification.request.content.body
    }

}
