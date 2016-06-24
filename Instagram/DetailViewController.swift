//
//  DetailViewController.swift
//  Instagram
//
//  Created by Prachi Bodas on 6/21/16.
//  Copyright © 2016 Prachi Bodas. All rights reserved.
//

import UIKit
import Parse
import Social

class DetailViewController: UIViewController {
    
    var post:[PFObject] = []
    
    var image:UIImage = UIImage()

    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var displayerView: UIImageView!
    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        
        //usernameLabel.text = "%mdkfa"
        
        if (post[0]["username"] == nil)
        {
            usernameLabel.text = "anonymous"
        }else{
            usernameLabel.text = post[0]["username"] as! String
        }
        
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
    
    //press fb share button

    @IBAction func fbShareButton(sender: AnyObject) {
        
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook){
            var facebookSheet:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            facebookSheet.setInitialText("Share on Facebook")
            facebookSheet.addImage(displayerView.image)
            self.presentViewController(facebookSheet, animated: true, completion: nil)
        } else {
            var alert = UIAlertController(title: "Accounts", message: "Please login to a Facebook account to share.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
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
