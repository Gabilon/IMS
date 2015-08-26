//
//  SignUpViewController.swift
//  IMS
//
//  Created by Gabriel Bermudez on 8/21/15.
//  Copyright (c) 2015 Gabriel Bermudez. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var profilePhotoImageView: UIImageView!
    
    @IBOutlet weak var userFirstName: UITextField!
    @IBOutlet weak var userLastName: UITextField!
    @IBOutlet weak var userEmailAddress: UITextField!
    @IBOutlet weak var userPassword: UITextField!
    @IBOutlet weak var userReEnterPassword: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func selectProfilePhotoButtonTapped(sender: AnyObject) {
        
        var myPickerController = UIImagePickerController()
        
        myPickerController.delegate = self
        myPickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        self.presentViewController(myPickerController, animated: true, completion: nil)
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]){
        
        profilePhotoImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    @IBAction func cancelButtonTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func SignUpButton(sender: AnyObject) {
        let firstName = userFirstName.text
        let lastName = userLastName.text
        let email = userEmailAddress.text
        let password = userPassword.text
        let repeatPassword = userReEnterPassword.text
        
        //check if fields are empty
        if (firstName.isEmpty || lastName.isEmpty || email.isEmpty || password.isEmpty || repeatPassword.isEmpty){
            
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
        
        if (password != repeatPassword) {
            
            //Alert window
            var myAlert = UIAlertController(title: "Alert!", message: "Passwords do not match.", preferredStyle: UIAlertControllerStyle.Alert)
            
            //Creating button to dismiss alert window
            let okButton = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
            
            //Adding okButton to the alert (appending it)
            myAlert.addAction(okButton)
            
            //presenting the alert to the viewController
            self.presentViewController(myAlert, animated: true, completion: nil)
        }
        
        let profileImageData = UIImageJPEGRepresentation(profilePhotoImageView.image, 1)
        
        if (profilePhotoImageView != nil){
            //Create PFFileObject to be sent Parse Cloud Service
        }
        
    }
    

}