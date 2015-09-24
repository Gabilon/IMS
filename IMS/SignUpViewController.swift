//
//  SignUpViewController.swift
//  IMS
//
//  Created by Gabriel Bermudez on 8/21/15.
//  Copyright (c) 2015 Gabriel Bermudez. All rights reserved.
//

import UIKit
import Parse
import Bolts

class SignUpViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var profilePhotoImageView: UIImageView!
    
    @IBOutlet weak var userFirstName: UITextField!
    @IBOutlet weak var userLastName: UITextField!
    @IBOutlet weak var userEmailAddress: UITextField!
    @IBOutlet weak var userPassword: UITextField!
    @IBOutlet weak var userReEnterPassword: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loadPictureEdit()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Text Field Delegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    @IBAction func selectProfilePhotoButtonTapped(sender: AnyObject) {
        
        let myPickerController = UIImagePickerController()
        
        myPickerController.delegate = self
        myPickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        self.presentViewController(myPickerController, animated: true, completion: nil)
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]){
        
        profilePhotoImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    @IBAction func cancelButtonTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func SignUpButton(sender: AnyObject) {
        
        self.view.endEditing(true)
        
        let firstName = userFirstName.text
        let lastName = userLastName.text
        let email = userEmailAddress.text
        let password = userPassword.text
        let repeatPassword = userReEnterPassword.text
        
        //check if fields are empty
        if (firstName!.isEmpty || lastName!.isEmpty || email!.isEmpty || password!.isEmpty || repeatPassword!.isEmpty){
            
            //Alert window
            let myAlert = UIAlertController(title: "Alert!", message: "All fields must be entered", preferredStyle: UIAlertControllerStyle.Alert)
            
            //Creating button to dismiss alert window
            let okButton = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
            
            //Adding okButton to the alert (appending it)
            myAlert.addAction(okButton)
            
            //presenting the alert to the viewController
            self.presentViewController(myAlert, animated: true, completion: nil)
            
            return
            
        }
        
        if (password != repeatPassword) {
            
            //Alert window
            let myAlert = UIAlertController(title: "Alert!", message: "Passwords do not match.", preferredStyle: UIAlertControllerStyle.Alert)
            
            //Creating button to dismiss alert window
            let okButton = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
            
            //Adding okButton to the alert (appending it)
            myAlert.addAction(okButton)
            
            //presenting the alert to the viewController
            self.presentViewController(myAlert, animated: true, completion: nil)
            
            return
        }
        
        let profileImageData = UIImageJPEGRepresentation(profilePhotoImageView.image!, 1)
        
        PFUser.logOut()
        //Parse User Object
        let myUser = PFUser()
        
        //declaring variables
        myUser.username = email
        myUser.password = password
        myUser.email = email
        
        //Set the objects to the Parse server (must be the same key)
        myUser.setObject(firstName!, forKey: "first_Name")
        myUser.setObject(lastName!, forKey: "last_Name")
        
        //Add up the image to the server
        if (profilePhotoImageView != nil){
            let profileImageFile = PFFile(data: profileImageData!)
            myUser.setObject(profileImageFile, forKey: "profile_picture")
            
        }
        //Show activity indicator
        let spiningActivity = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        
        spiningActivity.labelText = "Sending"
        spiningActivity.detailsLabelText = "Please wait"

        myUser.signUpInBackgroundWithBlock { (success:Bool,error:NSError?) -> Void in
            
            //Hiding activity animation
            spiningActivity.hide(true)
            
            var userMessage = "Registration is successful.  Please verify your email before loggin in!"
            
            if (!success){
            
                userMessage = "Could not register at this time.  Please try again later."
                
                //Parse error
                //userMessage = error!.localizedDescription
            }
            
            //Alert window
            let myAlert = UIAlertController(title: "Alert!", message:userMessage, preferredStyle: UIAlertControllerStyle.Alert)
            
            //Creating button to dismiss alert window
            let okButton = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default){ action in
                
                if(success)
                {
                    self.dismissViewControllerAnimated(true, completion: nil)
                }
                
            }
            
            
            //Adding okButton to the alert (appending it)
            myAlert.addAction(okButton)
            
            //presenting the alert to the viewController
            self.presentViewController(myAlert, animated: true, completion: nil)
        }

        
    }
    
    func loadPictureEdit(){
        
        profilePhotoImageView.layer.borderWidth = 1
        profilePhotoImageView.layer.masksToBounds = false
        profilePhotoImageView.layer.borderColor = UIColor.blackColor().CGColor
        profilePhotoImageView.layer.cornerRadius = profilePhotoImageView.frame.height/2
        profilePhotoImageView.clipsToBounds = true
    }
    

}
