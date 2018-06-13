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
        
        self.btnLogin.backgroundColor = UIColor.green
        self.btnLogout.backgroundColor = UIColor.red
        self.btnLogin.layer.cornerRadius = 5
        self.btnLogout.layer.cornerRadius = 5
        //adding the delegates
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
        
        
    }
    
    
    @IBAction func logIn(_ sender: Any) {
        AlertController.activityIndicatorTrigger(start: true, controller: self)
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
                AlertController.activityIndicatorTrigger(start: false, controller: self)
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

