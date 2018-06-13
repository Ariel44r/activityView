//
//  AlertController.swift
//  LoginApp
//
//  Created by Ariel Ramírez on 13/06/18.
//  Copyright © 2018 Ariel Ramírez. All rights reserved.
//

import UIKit


public class AlertController {
    
    public static var actInd = UIActivityIndicatorView()
    public static var activityView = UIView()
    public static var blurView = UIView()
    
    public static func activityIndicatorTrigger(start: Bool, controller: UIViewController) {
        if start {
            
            self.blurView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
            self.blurView.frame = controller.view.frame
            self.blurView.center = controller.view.center
            
            self.activityView.backgroundColor = UIColor.black
            self.activityView.layer.cornerRadius = 10
            self.activityView.frame = CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0)
            self.activityView.center = controller.view.center
            
            actInd.hidesWhenStopped = true
            actInd.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
            controller.view.addSubview(self.blurView)
            controller.view.addSubview(self.activityView)
            controller.view.addSubview(actInd)
            self.actInd.center = controller.view.center
            actInd.startAnimating()
            
        } else {
            self.actInd.stopAnimating()
            self.blurView.removeFromSuperview()
            self.activityView.removeFromSuperview()
        }
    }
    
}
