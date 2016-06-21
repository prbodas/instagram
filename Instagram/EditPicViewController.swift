//
//  EditPicViewController.swift
//  Instagram
//
//  Created by Prachi Bodas on 6/20/16.
//  Copyright © 2016 Prachi Bodas. All rights reserved.
//

import UIKit

class EditPicViewController: UIViewController {
    
    
    @IBOutlet weak var imageDisplay: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //erase prompt in textView when typing begins
        captionTextView.clearsOnInsertion = true
        
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
        
        //segues back to the main screen
        let storyboard = self.storyboard!
        print("storyboard done")
        let viewctrl = storyboard.instantiateViewControllerWithIdentifier("MainScreen")
        print("instantiation done")
        let mainScreen = viewctrl as! InstaMainViewController
        print("cast doen")
        self.presentViewController(mainScreen, animated: true, completion: {print ("controller presented")})
        
    }
    
    //caption code
    @IBOutlet weak var captionTextView: UITextView!
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}