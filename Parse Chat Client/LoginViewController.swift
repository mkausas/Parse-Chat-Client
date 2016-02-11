//
//  LoginViewController.swift
//  Parse Chat Client
//
//  Created by Martynas Kausas on 2/10/16.
//  Copyright © 2016 Martynas Kausas. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    var cancelAction: UIAlertAction!
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cancelAction = UIAlertAction(title: "Continue", style: .Cancel) { (UIAlertAction) -> Void in
            print("Pressed")
        }

        
    }
    
    
    
    
    @IBAction func signUpAction(sender: AnyObject) {
        let user = PFUser()
        user.username = usernameTextField.text!
        user.password = passwordTextField.text!
        user.email = "yo2@example.com"
        
        user.signUpInBackgroundWithBlock {
            (succeeded: Bool, error: NSError?) -> Void in
            if let error = error {
                let errorString = error.userInfo["error"] as? NSString

                let alert = UIAlertController()
                alert.addAction(self.cancelAction)
                alert.title = "Signup Error"
                alert.message = "\(errorString!)"
                self.presentViewController(alert, animated: true, completion: { () -> Void in
                    print("showing")
                })
            } else {
                // Hooray! Let them use the app now.
                self.transition()
            }
        }
    }
    
    func transition() {
        performSegueWithIdentifier("loginSegue", sender: self)
    }
    
    
    @IBAction func loginAction(sender: AnyObject) {
        print("logging in")

        PFUser.logInWithUsernameInBackground(usernameTextField.text!, password: passwordTextField.text!) {
            (user: PFUser?, error: NSError?) -> Void in
            print("logging in")
            if user != nil {
                // Do stuff after successful login.
                self.transition()
            } else {
                if let error = error {
                    // The login failed. Check error to see why.
                    let errorString = error.userInfo["error"] as? NSString
                    let alert = UIAlertController()
                    alert.addAction(self.cancelAction)
                    alert.title = "Signup Error"
                    alert.message = "\(errorString!)"
                    self.presentViewController(alert, animated: true, completion: { () -> Void in
                        print("showing")
                    })
                }
            }
        }
    }
    
    
}
