//
//  ViewController.swift
//  PushNotificationTaster
//
//  Created by Hitesh  Agarwal on 9/13/18.
//  Copyright © 2018 Hitesh  Agarwal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lblPushCount: UILabel!
    @IBOutlet weak var lblThumbCount: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setPushNotificationData()
    }
    
    func setPushNotificationData() {
        lblPushCount.text = String(UserDefaults.pushCount)
        
        lblThumbCount.text =  String(format: "👍 %@", String(UserDefaults.thumpCount)) 
    }

}

