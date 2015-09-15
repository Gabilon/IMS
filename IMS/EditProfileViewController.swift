//
//  EditProfileViewController.swift
//  IMS
//
//  Created by Gabriel Bermudez on 9/14/15.
//  Copyright (c) 2015 Gabriel Bermudez. All rights reserved.
//

import UIKit
import Parse

class EditProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var profilePictureImageView: UIImageView!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    
    //variable reference to update first name and last na
    var opener: LeftSideViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //load picture edit
        loadPictureEdit()
        
        //Load user details
        
        let userFirstName = PFUser.currentUser()?.objectForKey("first_Name") as! String
        let userLastName = PFUser.currentUser()?.objectForKey("last_Name") as! String
        
        firstNameTextField.text = userFirstName
        lastNameTextField.text = userLastName
        
        //Image data checking if it isn't null
        if(PFUser.currentUser()?.objectForKey("profile_picture") != nil){
            
            //image PFFile getting the file.
            let userImageFile:PFFile = PFUser.currentUser()?.objectForKey("profile_picture") as! PFFile
            
            //set the image the file (downloading it)
            userImageFile.getDataInBackgroundWithBlock({ (imageData:NSData?, error:NSError?) -> Void in
                
                if (imageData != nil){
                    
                self.profilePictureImageView.image = UIImage(data: imageData!)
                    
                }
            })
        }
    }
    
    //Function to dissmiss the keyboard when presing enter key
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Done button dismisses view controller
    @IBAction func doneButton(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }

    //Choose picture button
    @IBAction func chooseProfileButton(sender: AnyObject) {
        
        //Check pictures in iOS device
        var myPickerController = UIImagePickerController()
        myPickerController.delegate = self;
        myPickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        self.presentViewController(myPickerController, animated: true, completion: nil)

    }
    
    //Setting picture to the UIImageView
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]){
        profilePictureImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //Save button
    @IBAction func saveButton(sender: AnyObject) {
        //Get current User
        let myUser:PFUser = PFUser.currentUser()!
        
        //Get Profile Picture
        let profileImageData = UIImageJPEGRepresentation(profilePictureImageView.image, 1)
        
        //Check if first name and last name are empty (and pic)
        if(firstNameTextField.text.isEmpty || lastNameTextField.text.isEmpty || (profileImageData == nil)){
            
            //Alert window
            var myAlert = UIAlertController(title: "Alert!", message: "First and Last name's cannot be empty", preferredStyle: UIAlertControllerStyle.Alert)
            
            //Creating button to dismiss alert window
            let okButton = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
            
            //Adding okButton to the alert (appending it)
            myAlert.addAction(okButton)
            
            //presenting the alert to the viewController
            self.presentViewController(myAlert, animated: true, completion: nil)
            
            return
        }
        
        //If user decides to update passwords
        if(!passwordTextField.text.isEmpty && (passwordTextField.text != repeatPasswordTextField.text)){
            //Alert window
            var myAlert = UIAlertController(title: "Alert!", message: "Passwords do not match.", preferredStyle: UIAlertControllerStyle.Alert)
            
            //Creating button to dismiss alert window
            let okButton = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
            
            //Adding okButton to the alert (appending it)
            myAlert.addAction(okButton)
            
            //presenting the alert to the viewController
            self.presentViewController(myAlert, animated: true, completion: nil)
            
            return
        }
        
        //setting both first name and last name
        let userFirstName = firstNameTextField.text
        let userLastName = lastNameTextField.text
        
        myUser.setObject(userFirstName, forKey: "first_Name")
        myUser.setObject(userLastName, forKey: "last_Name")
        
        //set new password
        if(!passwordTextField.text.isEmpty){
            let userPassword = passwordTextField.text
            myUser.password = userPassword
            
        }
        
        //Set profile picture
        if (profileImageData != nil){
            let profileFileObject = PFFile(data:profileImageData)
            myUser.setObject(profileFileObject, forKey: "profile_picture")
        }
        
        //Set Display activity indicator
        
        let loadingNotification = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        
        loadingNotification.labelText = "Updating Profile"
        
        myUser.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            
            //Hide Activity Indicator
            loadingNotification.hide(true)
            
            if (error != nil){
                //Alert window
                var myAlert = UIAlertController(title: "Alert!", message: "We are sorry, user details were not stored.  Check your internet!", preferredStyle: UIAlertControllerStyle.Alert)
                
                //Creating button to dismiss alert window
                let okButton = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
                
                //Adding okButton to the alert (appending it)
                myAlert.addAction(okButton)
                
                //presenting the alert to the viewController
                self.presentViewController(myAlert, animated: true, completion: nil)
                
                return
            }
            
            if (success){
                
                //Alert window
                var myAlert = UIAlertController(title: "Success", message: "Your Profile has been updated!", preferredStyle: UIAlertControllerStyle.Alert)
                
                //Creating button to dismiss alert window
                let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: { (action: UIAlertAction!) -> Void in
                    
                    self.dismissViewControllerAnimated(true, completion: { () -> Void in
                        self.opener.loadUserDetails()
                    })
                    
                })
                
                //Adding okButton to the alert (appending it)
                myAlert.addAction(okAction)
                
                //presenting the alert to the viewController
                self.presentViewController(myAlert, animated: true, completion: nil)
                
                return
            }
            
        }

        
    }
    
    func loadPictureEdit(){
        
        profilePictureImageView.layer.borderWidth = 1
        profilePictureImageView.layer.masksToBounds = false
        profilePictureImageView.layer.borderColor = UIColor.blackColor().CGColor
        profilePictureImageView.layer.cornerRadius = profilePictureImageView.frame.height/2
        profilePictureImageView.clipsToBounds = true
    }
    
    
    
}


