//
//  LoginViewController.swift
//  Instagram
//
//  Created by Prachi Bodas on 6/20/16.
//  Copyright © 2016 Prachi Bodas. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //user and pass fields
    
    @IBOutlet weak var userField: UITextField!

    @IBOutlet weak var passField: UITextField!
    
    //sign up code
    
    @IBAction func signUpPressed(sender: AnyObject) {
        let newUser = PFUser()
        newUser.username = userField.text
        newUser.password = passField.text
        
        newUser.signUpInBackgroundWithBlock{
            (success: Bool, error: NSError?) -> Void in
            if (success){
                print ("woohoo")
                self.loginPressed("woo")
                
            }else{
                print ("noooo")
                self.performSegueWithIdentifier("toTab", sender: newUser)
                //TODO: check and handle error codes for parse
            }
            
        }
        
    }
    
    //sign in code
    
    
    @IBAction func loginPressed(sender: AnyObject) {
        PFUser.logInWithUsernameInBackground(userField.text!, password: passField.text!)
        { (user:PFUser?, error:NSError?) -> Void in
            if (user != nil)
            {
                print ("signed in")
                
                /*print("completions begin")
                let storyboard = self.storyboard!
                print("storyboard done")
                let viewctrl = storyboard.instantiateViewControllerWithIdentifier("MainScreen")
                print("instantiation done")
                self.presentViewController(viewctrl, animated: true, completion: nil)*/
                
                self.performSegueWithIdentifier("toTab", sender: user)
                
                
                print ("performed")
                
            }else{
                print ("not signed ijn")
                //TODO: handle error codes
            }
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
