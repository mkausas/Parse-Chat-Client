//
//  ChatViewController.swift
//  Parse Chat Client
//
//  Created by Martynas Kausas on 2/10/16.
//  Copyright © 2016 Martynas Kausas. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController {

    
    @IBOutlet weak var messageTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sendMessage(sender: AnyObject) {
        
        let message = PFObject(className:"Message")
        message["text"] = messageTextField.text!
        message.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                print("Sent: \(message["text"])")
            } else {
                print("Error: \(error?.description)")
            }
        }
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
