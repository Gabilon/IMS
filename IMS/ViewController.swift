//
//  ViewController.swift
//  IMS
//
//  Created by Gabriel Bermudez on 8/20/15.
//  Copyright (c) 2015 Gabriel Bermudez. All rights reserved.
//

import UIKit
import Parse
import Bolts

class ViewController: UIViewController, UITextFieldDelegate {
    //Text fields connected
    @IBOutlet weak var userEmailAddressTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    @IBOutlet weak var signInScrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signInScrollView.keyboardDismissMode = .OnDrag
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Function to dissmiss the keyboard when presing enter key
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    @IBAction func signLogginButton(sender: AnyObject) {
        
        //transport textfields to variables
        let userEmail = userEmailAddressTextField.text
        let userPassword = userPasswordTextField.text
        
        //If it's empty, return and it will not let the func continue
        if(userEmail.isEmpty || userPassword.isEmpty){
            
            //Alert window
            var myAlert = UIAlertController(title: "Alert!", message: "All fields must be entered", preferredStyle: UIAlertControllerStyle.Alert)
            
            //Creating button to dismiss alert window
            let okButton = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
            
            //Adding okButton to the alert (appending it)
            myAlert.addAction(okButton)
            
            //presenting the alert to the viewController
            self.presentViewController(myAlert, animated: true, completion: nil)
            return
        }
        
        //Spinning thing and does not let the user hit something else
        let spiningActivity = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        
        spiningActivity.labelText = "Loggin in"
        spiningActivity.detailsLabelText = "Please wait"
        
        PFUser.logOut()
        PFUser.logInWithUsernameInBackground(userEmail, password: userPassword) { (user:PFUser?, error:NSError?) -> Void in
            
            //Close spinning activity
            spiningActivity.hide(true)
            //MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
            
            var userMessage = "Welcome!"
            
            //user:PFUser?
            if (user != nil){
                
                //Remember the sign in state
                let userName:String? = user?.username
                
                NSUserDefaults.standardUserDefaults().setObject(userName, forKey: "user_name")
                
                NSUserDefaults.standardUserDefaults().synchronize()
                
                
                //Navigate to Protected Main Page
                
                var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                
                appDelegate.buildUserInterface()
                
                
                
                
                
            } else {
                userMessage = error!.localizedDescription
                
                //Alert
                var myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert)
                //Ok button
                let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
                
                //adds the okAction to the alert
                myAlert.addAction(okAction)
                
                //presents it to the ViewController.swift
                self.presentViewController(myAlert, animated: true, completion: nil)
            }
            
            
        }
        
    }
}

