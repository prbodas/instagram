//
//  FilterCell.swift
//  Instagram
//
//  Created by Prachi Bodas on 6/23/16.
//  Copyright © 2016 Prachi Bodas. All rights reserved.
//

import UIKit

class FilterCell: UICollectionViewCell {
    
    
    @IBOutlet weak var filterButton: UIButton!
    
    var itemNum = 0
    
    var originalImage = UIImage()
    
    var imageDisplay = UIImageView()
    
    var viewctrl:EditPicViewController = EditPicViewController()
    
    @IBAction func buttonSelected(sender: AnyObject) {
        
        //fixes UI
        self.superview?.userInteractionEnabled = false
        
        let subs:[UIView] = (self.superview?.subviews)!
        
        print("subscount=\(subs.count)")
        
        for s in subs
        {
            if s is FilterCell{
                let ss = s as! FilterCell
                ss.filterButton.backgroundColor = UIColor.whiteColor()
            }
        }
        
        self.filterButton.backgroundColor = UIColor.grayColor()
        self.superview?.userInteractionEnabled = true
        
        viewctrl.applyFilter(itemNum)
    }
    
}
