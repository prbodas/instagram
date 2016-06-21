//
//  EditPicViewController.swift
//  Instagram
//
//  Created by Prachi Bodas on 6/20/16.
//  Copyright © 2016 Prachi Bodas. All rights reserved.
//

import UIKit

class EditPicViewController: UIViewController {
    
    @IBOutlet weak var captionView: UITextView!
    
    @IBOutlet weak var imageDisplay: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //erase prompt in textView when typing begins
        captionView.clearsOnInsertion = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setPicture(picture:UIImage)
    {
        imageDisplay.image = picture
        print ("pic done")
    }
    
    @IBAction func doneButton(sender: AnyObject) {
        
        //puts the post into the database
        Post.postUserImage(imageDisplay.image, withCaption: captionView.text, withCompletion: nil)
        
        
        //segues back to the main screen
        let storyboard = self.storyboard!
        print("storyboard done")
        let viewctrl = storyboard.instantiateViewControllerWithIdentifier("TabScreen")
        print("instantiation done")
        print("cast doen")
        self.presentViewController(viewctrl, animated: true, completion: {print ("controller presented")})
        
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
