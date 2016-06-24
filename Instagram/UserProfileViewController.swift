//
//  UserProfileViewController.swift
//  Instagram
//
//  Created by Prachi Bodas on 6/20/16.
//  Copyright © 2016 Prachi Bodas. All rights reserved.
//

import UIKit
import Parse

class UserProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tableDataArray = []
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //get user
        usernameLabel.text = PFUser.currentUser()?.username

        let query = PFQuery(className: "Post")
        query.orderByDescending("createdAt")
        query.whereKey("username", equalTo: (PFUser.currentUser()?.username)!)
        
        query.findObjectsInBackgroundWithBlock  {
            (objects:[PFObject]?, error: NSError?) -> Void in
            if (error == nil)
            {
                self.tableDataArray = objects!
                print("counterr:")
                print(self.tableDataArray.count)
            }else{
                print ("error")
            }
            self.tableView.reloadData()
        }
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("userPostCell", forIndexPath: indexPath) as! UserPostCell
        
        let object:PFObject = tableDataArray[indexPath.row] as! PFObject
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
        
        if (object["timestamp"] == nil)
        {
            cell.timestampLabel.text = "time hidden"
        }else{
            cell.timestampLabel.text = object["timestamp"] as! String
        }
        
        cell.captionLabel.text = object["caption"] as! String
            
        return cell

    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableDataArray.count
    }
    
    
    
    @IBAction func logOutUser(sender: AnyObject) {
        PFUser.logOutInBackgroundWithBlock { (error: NSError?) in
            self.performSegueWithIdentifier("toLoginScreen", sender: nil)
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
