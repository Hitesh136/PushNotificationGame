//
//  CustomAlertController.swift
//  PushNotificationTaster
//
//  Created by Hitesh  Agarwal on 9/15/18.
//  Copyright © 2018 Hitesh  Agarwal. All rights reserved.
//

import UIKit

class CustomAlertController: UIViewController {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubtitle: UILabel!
    
    var viewTag = 89789789789
    var alertTitle = ""
    var subTitle = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()


        lblTitle.text = alertTitle
        lblSubtitle.text = subTitle
    }
    
    static func create(title: String, subtitle: String) -> CustomAlertController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let customAlertController = storyboard.instantiateViewController(withIdentifier: "CustomAlertController") as? CustomAlertController {
        
            customAlertController.alertTitle = title
            customAlertController.subTitle = subtitle
            return customAlertController
            
        }
        return nil
    }
    
    @IBAction func actionOk(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
}
