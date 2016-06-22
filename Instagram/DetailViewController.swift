//
//  DetailViewController.swift
//  Instagram
//
//  Created by Prachi Bodas on 6/21/16.
//  Copyright © 2016 Prachi Bodas. All rights reserved.
//

import UIKit
import Parse

class DetailViewController: UIViewController {
    
    var post:[PFObject] = []
    
    var image:UIImage = UIImage()

    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var displayerView: UIImageView!

    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        
        usernameLabel.text = post[0]["username"] as! String
        
        if (post[0]["timestamp"] == nil)
        {
            timestampLabel.text = "time hidden"
        }else{
            timestampLabel.text = post[0]["timestamp"] as! String
        }

        captionLabel.text = post[0]["caption"] as! String
        
        displayerView.image = image


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
