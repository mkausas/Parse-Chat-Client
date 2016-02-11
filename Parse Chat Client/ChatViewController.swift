//
//  ChatViewController.swift
//  Parse Chat Client
//
//  Created by Martynas Kausas on 2/10/16.
//  Copyright © 2016 Martynas Kausas. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    
    var messages: [PFObject]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getMessages()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: "onRefresh", userInfo: nil, repeats: true)
    }
    
    func onRefresh() {
        getMessages()
    }
    
    func getMessages() {
        let query = PFQuery(className: "Message")
        query.addDescendingOrder("createdAt")
        query.includeKey("user")
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) scores.")
                
                self.messages = objects
                self.tableView.reloadData()
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("messageCell", forIndexPath: indexPath) as! MessageTableViewCell
        cell.message = messages[indexPath.row]
//        print("user = \(messages[indexPath.row]["user"]?.username)")
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let messages = messages {
            return messages.count
        }
        
        return 0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sendMessage(sender: AnyObject) {
        
        let message = PFObject(className:"Message")
        message["text"] = messageTextField.text!
        message["user"] = PFUser.currentUser()
        print("current user = \(PFUser.currentUser()?.username!)")
        message.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                print("Sent: \(message["text"]) from \(message["user"].username!)")
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
