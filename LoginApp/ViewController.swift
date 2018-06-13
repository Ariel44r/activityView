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

class ViewController: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate {

    //label to display name of logged in user
    @IBOutlet weak var labelUserEmail: UILabel!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnLogout: UIButton!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //error object
        var error : NSError?
        
        /*
        //setting the error
        GGLContext.sharedInstance().configureWithError(&error)
        
        //if any error stop execution and print error
        if error != nil{
            print(error ?? "google error")
            return
        }*/
        
        self.btnLogin.backgroundColor = UIColor.red
        //adding the delegates
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
        
        //getting the signin button and adding it to view
        
    }
    
    @IBAction func logIn(_ sender: Any) {
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

