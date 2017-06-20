//
//  AlertDialog.swift
//  Finalproject0612
//
//  Created by MAC on 2017/6/12.
//  Copyright © 2017年 MAC. All rights reserved.
//

import Foundation
import UIKit

// A simple convenience class to present alerts, to avoid lots of UIAlertController code duplication.
class AlertDialog {
    
    class func showAlert(_ title: String, message: String, viewController: UIViewController) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let dismissAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(dismissAction)
        
        viewController.present(alertController, animated: true, completion: nil)
        
    }
    
}
