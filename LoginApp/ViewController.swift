//
//  ViewController.swift
//  LoginApp
//
//  Created by Ariel Ramírez on 12/06/18.
//  Copyright © 2018 Ariel Ramírez. All rights reserved.
//

import UIKit
import Google
import GoogleSignIn
import ObjectMapper

class ViewController: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate {

    //MARK: Outlets
    @IBOutlet weak var labelUserEmail: UILabel!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnLogout: UIButton!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    
    //MARK: Instances
    var actInd: UIActivityIndicatorView?
    var activityView: UIView?
    var blurView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        /*
        //setting the error
        GGLContext.sharedInstance().configureWithError(&error)
        
        //if any error stop execution and print error
        if error != nil{
            print(error ?? "google error")
            return
        }*/
        
        self.btnLogin.backgroundColor = UIColor.red
        self.btnLogin.layer.cornerRadius = 5
        self.btnLogout.layer.cornerRadius = 5
        //adding the delegates
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
        
        self.actInd = UIActivityIndicatorView()
        self.activityView = UIView()
        self.blurView = UIView()
        
    }
    
    func activityIndicatorTrigger(start: Bool) {
        if start {
            
            self.blurView?.backgroundColor = UIColor.black.withAlphaComponent(0.7)
            self.blurView?.frame = self.view.frame
            self.blurView?.center = self.view.center
            
            self.activityView?.backgroundColor = UIColor.black
            self.activityView?.layer.cornerRadius = 10
            self.activityView?.frame = CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0)
            self.activityView?.center = self.view.center
            
            actInd!.hidesWhenStopped = true
            actInd!.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
            self.view.addSubview(self.blurView!)
            self.view.addSubview(self.activityView!)
            self.view.addSubview(actInd!)
            self.actInd?.center = self.view.center
            actInd!.startAnimating()

        } else {
            self.actInd!.stopAnimating()
            self.blurView?.removeFromSuperview()
            self.activityView?.removeFromSuperview()
        }
    }
    
    @IBAction func logIn(_ sender: Any) {
        self.activityIndicatorTrigger(start: true)
        GIDSignIn.sharedInstance().signIn()
    }
    
    @IBAction func logOut(_ sender: Any) {
        GIDSignIn.sharedInstance().signOut()
        self.lblName.text = ""
        self.lblEmail.text = ""
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if error == nil {
            if let profile = user.profile as GIDProfileData? {
                self.lblName.text = profile.name
                self.lblEmail.text = profile.email
                self.activityIndicatorTrigger(start: false)
            }
        }
    }
    
    func sign(inWillDispatch signIn: GIDSignIn!, error: Error!) {
        //myActivityIndicator.stopAnimating()
    }
    
    // Present a view that prompts the user to sign in with Google
    func sign(_ signIn: GIDSignIn!, present viewController: UIViewController!) {
        self.present(viewController, animated: true, completion: nil)
    }
    
    // Dismiss the "Sign in with Google" view
    func sign(_ signIn: GIDSignIn!, dismiss viewController: UIViewController!) {
        viewController.dismiss(animated: true, completion: nil)
    }
    
    
}

