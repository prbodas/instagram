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
    
    @IBOutlet weak var filterPicker: UISegmentedControl!
    
    var originalImage = UIImage()
    

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
        originalImage = picture
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
    
    //tap gesture recognizer
    
    @IBAction func onTap(sender: AnyObject) {
        captionView.endEditing(true)
    }
    
    
    @IBAction func segmentChanged(sender: AnyObject) {
        let ind = filterPicker.selectedSegmentIndex
        if (ind == 1)
        {
            let cimage:CIImage = CIImage(image: originalImage)!
            
            let filter = CIFilter(name: "CISepiaTone")
            filter!.setValue(cimage, forKey: kCIInputImageKey)
            filter!.setValue(0.5, forKey: kCIInputIntensityKey)
            
            let cgim = self.convertCIImageToCGImage(filter!.outputImage!)
            
            let newImage = UIImage(CGImage: cgim)
            self.imageDisplay.image = newImage
            
        }
    }
    
    func convertCIImageToCGImage(inputImage: CIImage) -> CGImage! {
        let context = CIContext(options: nil)
        let img =  context.createCGImage(inputImage, fromRect: inputImage.extent)
        return img
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
