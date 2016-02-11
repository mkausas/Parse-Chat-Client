//
//  MessageCellTableViewCell.swift
//  Parse Chat Client
//
//  Created by Martynas Kausas on 2/10/16.
//  Copyright © 2016 Martynas Kausas. All rights reserved.
//

import UIKit
import Parse

class MessageTableViewCell: UITableViewCell {

    @IBOutlet weak var userLabel: UILabel!
    
    @IBOutlet weak var messageLabel: UILabel!
    
    var message: PFObject! {
        didSet {
            print("about to set")
            if let user = message.objectForKey("user") {
                if let username = user.username {
                    userLabel.text = username
                }
            }
            messageLabel.text = message.objectForKey("text") as? String
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
