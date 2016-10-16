//
//  ViewController.swift
//  socialapp
//
//  Created by Pierre-Henry Soria on 09/10/2016.
//  Copyright © 2016 Pierre-Henry Soria. All rights reserved.
//

import UIKit
import Firebase
import FBSDKCoreKit
import FBSDKLoginKit

class SignInViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func facebookButtonTrapped(_ sender: AnyObject) {
        let facebookLogin = FBSDKLoginManager()
        
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) {
            (result, error) in
            if error != nil {
                print("Oops! Unable to authentication with Facebook: \(error)")
            } else if result?.isCancelled == true {
                print("Sad..! User cancelled Facebook authentication")
            } else {
                print("Successfully authenticated with Facebook!")
                
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuth(credential)
            }
        }
    }
    
    
    func firebaseAuth(_ credential: FIRAuthCredential) {
        FIRAuth.auth()?.signIn(with: credential, completion: {
            (user, error) in
            if error != nil {
                print("Unable to authenticate with Firebase: \(error)")
            } else {
                print("Successfully authenticated to Firebase!")
            }
        })
    }
}

