//
//  InstaMainViewController.swift
//  Instagram
//
//  Created by Prachi Bodas on 6/20/16.
//  Copyright © 2016 Prachi Bodas. All rights reserved.
//

import UIKit

class InstaMainViewController: UIViewController, UIImagePickerControllerDelegate,
    UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set noCameraView invisible
        noCameraView.hidden = true;
        
    }

    override func didReceiveMemoryWarning(){
        super.didReceiveMemoryWarning()
    }
    
    
    //no camera view code
    
    @IBOutlet weak var noCameraView: UIView!
    
    @IBAction func closeNoCam(sender: AnyObject) {
        noCameraView.hidden = true;
        
    }
    
    //take picture code
    
    @IBAction func takePicButton(sender: AnyObject) {
        if (UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera))
        {
            let vc = UIImagePickerController()
            vc.delegate = self
            vc.allowsEditing = true
            vc.sourceType = UIImagePickerControllerSourceType.Camera
    
            self.presentViewController(vc, animated: true, completion: {print("camera open")})
        }else{
            noCameraView.hidden = false
        }
    }
    
    func imagePickerController(picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        // Get the image captured by the UIImagePickerController
        
        print ("pickerControlller called")
        
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        
        print("editedimage ok")
        
        // Do something with the images (based on your use case)
        
        // Dismiss UIImagePickerController to go back to your original view controller
        dismissViewControllerAnimated(true, completion:{
            
                //open the photo-editing controller programatically
                print("completions begin")
                let storyboard = self.storyboard!
                print("storyboard done")
                let viewctrl = storyboard.instantiateViewControllerWithIdentifier("EditPicScreen")
                print("instantiation done")
                let editScreen = viewctrl as! EditPicViewController
                print("cast doen")
                //editScreen.setPicture(editedImage)
                //print ("pic set")
            self.presentViewController(editScreen, animated: true, completion: {editScreen.setPicture(editedImage); print ("controller presented")})
            
            
            })
        
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
