//
//  EditPicViewController.swift
//  Instagram
//
//  Created by Prachi Bodas on 6/20/16.
//  Copyright © 2016 Prachi Bodas. All rights reserved.
//

import UIKit

class EditPicViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectView: UICollectionView!
    
    @IBOutlet weak var captionView: UITextView!
    
    @IBOutlet weak var imageDisplay: UIImageView!
    
    
    var originalImage = UIImage()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //erase prompt in textView when typing begins
        captionView.clearsOnInsertion = true
        
        collectView.dataSource = self
        collectView.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setPicture(picture:UIImage)
    {
        imageDisplay.image = picture
        originalImage = picture
        
        //imageDisplay.frame = CGRectMake(imageDisplay.frame.origin.x, imageDisplay.frame.origin.y,
                                        //picture.size.width*0.7, picture.size.height*0.7);
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
    
    
//    @IBAction func segmentChanged(sender: AnyObject) {
//        let ind = filterPicker.selectedSegmentIndex
//        let cimage:CIImage = CIImage(image: originalImage)!
//        
//        switch ind {
//            case 0:
//                imageDisplay.image = originalImage
//            
//            case 1:
//                
//                let filter = CIFilter(name: "CISepiaTone")
//                filter!.setValue(cimage, forKey: kCIInputImageKey)
//                filter!.setValue(0.7, forKey: kCIInputIntensityKey)
//                
//                let cgim = self.convertCIImageToCGImage(filter!.outputImage!)
//                
//                let newImage = UIImage(CGImage: cgim)
//                self.imageDisplay.image = newImage
//            
//            case 2:
//                
//                let filter = CIFilter(name: "CISepiaTone")
//                filter!.setValue(cimage, forKey: kCIInputImageKey)
//                filter!.setValue(0.7, forKey: kCIInputIntensityKey)
//                
//                let cgim = self.convertCIImageToCGImage(filter!.outputImage!)
//                
//                let newImage = UIImage(CGImage: cgim)
//                self.imageDisplay.image = newImage
//            default:
//                imageDisplay.image = originalImage
//        }
//        
//    }
    
    //instance context variable to stop resource drain
    let context = CIContext(options: nil)
    
    func convertCIImageToCGImage(inputImage: CIImage) -> CGImage! {
        let img =  context.createCGImage(inputImage, fromRect: inputImage.extent)
        return img
    }
    
    
    //collectionView stuff
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        // Access
        let cell = collectView.dequeueReusableCellWithReuseIdentifier("filterCell", forIndexPath: indexPath) as! FilterCell
        // Do any custom modifications you your cell, referencing the outlets you defined in the Custom cell file.
        cell.backgroundColor = UIColor.whiteColor()
        cell.itemNum = indexPath.item
        cell.originalImage = originalImage
        cell.imageDisplay = imageDisplay
        cell.viewctrl = self
        cell.filterButton.setTitle(titles[indexPath.item], forState: UIControlState.Normal)
        return cell
    }
    
    var titles = ["Original", "Sepia", "Invert", "Black & White", "Poster", "Saturate",
                  "Fade Color", "Blur", "Sharpen"]
    
    func applyFilter (ind:Int)
    {
        let cimage:CIImage = CIImage(image: originalImage)!
        var newImage = UIImage()

        switch ind {
        case 0:
            
            newImage = originalImage
            
        case 1:
            
            let filter = CIFilter(name: "CISepiaTone")
            filter!.setValue(cimage, forKey: kCIInputImageKey)
            filter!.setValue(0.7, forKey: kCIInputIntensityKey)
            
            let cgim = self.convertCIImageToCGImage(filter!.outputImage!)
            
            newImage = UIImage(CGImage: cgim)
            
        case 2:
            
            let filter = CIFilter(name: "CIColorInvert")
            filter!.setValue(cimage, forKey: kCIInputImageKey)
            
            let cgim = self.convertCIImageToCGImage(filter!.outputImage!)
            
            newImage = UIImage(CGImage: cgim)
            
        case 3:
            
            let filter = CIFilter(name: "CIPhotoEffectNoir")
            filter!.setValue(cimage, forKey: kCIInputImageKey)
            //filter!.setValue(CIColor.init(red: 0.5, green: 0.5, blue: 0.5), forKey: kCIInputColorKey)
            
            let cgim = self.convertCIImageToCGImage(filter!.outputImage!)
            
            newImage = UIImage(CGImage: cgim)
            
        case 4:
            
            let filter = CIFilter(name: "CIColorPosterize")
            filter!.setValue(cimage, forKey: kCIInputImageKey)
            
            let cgim = self.convertCIImageToCGImage(filter!.outputImage!)
            
            newImage = UIImage(CGImage: cgim)
            
        case 5:
            
            let filter = CIFilter(name: "CIPhotoEffectChrome")
            filter!.setValue(cimage, forKey: kCIInputImageKey)
            
            let cgim = self.convertCIImageToCGImage(filter!.outputImage!)
            
            newImage = UIImage(CGImage: cgim)
        
        case 6:
            
            let filter = CIFilter(name: "CIPhotoEffectFade")
            filter!.setValue(cimage, forKey: kCIInputImageKey)
            
            let cgim = self.convertCIImageToCGImage(filter!.outputImage!)
            
            newImage = UIImage(CGImage: cgim)

        case 7:
            
            let filter = CIFilter(name: "CIBoxBlur")
            filter!.setValue(cimage, forKey: kCIInputImageKey)
            
            let cgim = self.convertCIImageToCGImage(filter!.outputImage!)
            
            newImage = UIImage(CGImage: cgim)
            
        case 8:
            
            let filter = CIFilter(name: "CINoiseReduction")
            filter!.setValue(cimage, forKey: kCIInputImageKey)
            
            let cgim = self.convertCIImageToCGImage(filter!.outputImage!)
            
            newImage = UIImage(CGImage: cgim)
        
        default:
            newImage = originalImage
        }
        
        self.imageDisplay.image = newImage

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
