//
//  UserPostCell.swift
//  Instagram
//
//  Created by Prachi Bodas on 6/22/16.
//  Copyright © 2016 Prachi Bodas. All rights reserved.
//

import UIKit

class UserPostCell: UITableViewCell {

    @IBOutlet weak var displayerView: UIImageView!
    
    @IBOutlet weak var captionLabel: UILabel!
    
    @IBOutlet weak var timestampLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
