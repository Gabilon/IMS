//
//  PasswordResetViewController.swift
//  IMS
//
//  Created by Gabriel Bermudez on 9/11/15.
//  Copyright (c) 2015 Gabriel Bermudez. All rights reserved.
//

import UIKit
import Parse

class PasswordResetViewController: UIViewController {

    @IBOutlet weak var emailAddressTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        self.edgesForExtendedLayout = UIRectEdge()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //send email address to Parse
    @IBAction func sendButtonTapped(sender: AnyObject) {
        
        let emailAddress = emailAddressTextField.text
        
        if emailAddress.isEmpty{
           
            //Display a warning message
            let userMessage:String = "Please type in your email"
            var myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert)
            
            let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default){ action in
                return
            }
            
            myAlert.addAction(okAction)
            self.presentViewController(myAlert, animated: true, completion: nil)
           return
        }
        
        //Show activity indicator
        let spiningActivity = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        
        spiningActivity.labelText = "Sending"
        spiningActivity.detailsLabelText = "Please wait"
        
        
        PFUser.requestPasswordResetForEmailInBackground(emailAddress, block: { (success:Bool, error:NSError?) -> Void in
            
            spiningActivity.hide(true)
            
            if(error != nil){
                // Display error message
                let userMessage:String = error!.localizedDescription
                var myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert)
                
                let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default){ action in
                    
                    return
                }
                
                myAlert.addAction(okAction)
                self.presentViewController(myAlert, animated: true, completion: nil)
                
            } else {
                
                
                // Display success message
                let userMessage:String = "An email message has been sent to \(emailAddress)"
                self.displayMessage(userMessage)
            }
            
        })
        
    }
    
    func displayMessage(userMessage:String){
        
        var myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert)
        
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default){ action in
            
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        
        myAlert.addAction(okAction)
        self.presentViewController(myAlert, animated: true, completion: nil)
        
        
        
        
    }
    
    //cancel to sing in page
    @IBAction func cancelButtonTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
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
