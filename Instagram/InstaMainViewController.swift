//
//  InstaMainViewController.swift
//  Instagram
//
//  Created by Prachi Bodas on 6/20/16.
//  Copyright © 2016 Prachi Bodas. All rights reserved.
//

import UIKit
import Parse

class InstaMainViewController: UIViewController, UIImagePickerControllerDelegate,
    UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var tableDataArray:[PFObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.timerSelector()
        
        //set up refresh control
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)
        
        //set noCameraView invisible
        noCameraView.hidden = true;
        tableView.dataSource = self;
        tableView.delegate = self;
        
        tableView.rowHeight = 300
        //tableView.rowHeight = UITableViewAutomaticDimension
        
        NSTimer.scheduledTimerWithTimeInterval(10, target: self, selector: "timerSelector", userInfo: nil, repeats: true)
        
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
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableDataArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("postCell", forIndexPath: indexPath) as! PostCell
        
        let object = tableDataArray[tableDataArray.count - indexPath.row - 1]
        //print(object)
        
        let pfile = object["media"]
        pfile.getDataInBackgroundWithBlock{
            (data:NSData?, error: NSError?) -> Void in
            if (error == nil)
            {
                let image = UIImage(data:data!)
                cell.displayerView.image = image
            }
        }
        
        var username = object["username"]
        if (username == nil){username = "anonymous"}
        
        cell.usernameLabel.text = username as! String
        return cell
    }

    
    //timer refresh code
    func timerSelector()
    {
        print("timerSelecting")
        self.refreshTableView()
        
    }

    
    //control refresh actions
    func refreshControlAction(refreshControl: UIRefreshControl) {
        
            self.refreshTableView()
                                                                        
            // Tell the refreshControl to stop spinning
            refreshControl.endRefreshing()
    }
    
    
    func refreshTableView()
    {
        let query = PFQuery(className: "Post")
        query.findObjectsInBackgroundWithBlock{
            (objects:[PFObject]?, error: NSError?) -> Void in
            if (error == nil)
            {
                self.tableDataArray = objects!
                print("count:")
                print(self.tableDataArray.count)
            }else{
                print ("error")
            }
            
        }
        tableView.reloadData()
    }
    
    
    //segue prep
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        super.prepareForSegue(segue, sender: nil)
        if (segue.identifier == "toDetails")
        {
            let destination = segue.destinationViewController as! DetailViewController
            let indexPath = tableView.indexPathForCell(sender as! PostCell)
            destination.post = [self.tableDataArray[self.tableDataArray.count - 1 - (indexPath?.row)!]]
            let view = (sender as! PostCell).displayerView
            let img = view.image
            
            if (img == nil)
            {
                print ("nil")
            }
            
            destination.image = img!
            
            print ("did the thing")
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
