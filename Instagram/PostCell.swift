//
//  PostCell.swift
//  Instagram
//
//  Created by Prachi Bodas on 6/21/16.
//  Copyright © 2016 Prachi Bodas. All rights reserved.
//

import UIKit
import Parse

class PostCell: UITableViewCell {

    @IBOutlet weak var displayerView: UIImageView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func addCellData(post:PFObject)
    {
        
        //displayerView.image = post["media"] as! UIImage
        
        post.fetchIfNeededInBackgroundWithBlock{
            (object:PFObject?, error:NSError?) -> Void in
            if (error == nil)
            {
                //object?.objectForKey("media") as! PFFile
                //self.displayerView.image =
                self.usernameLabel.text = object?.objectForKey("user")?.username!
            }else{
                print ("error")
            }
        }

    }

}
