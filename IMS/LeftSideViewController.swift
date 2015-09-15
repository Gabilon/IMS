//
//  LeftSideViewController.swift
//  IMS
//
//  Created by Gabriel Bermudez on 9/11/15.
//  Copyright (c) 2015 Gabriel Bermudez. All rights reserved.
//

import UIKit
import Parse

class LeftSideViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var userProfilePicture: UIImageView!
    @IBOutlet weak var userFirstNameLabel: UILabel!
    @IBOutlet weak var userLastNameLabel: UILabel!
    
    
    
    var menuItems: [String] = ["Main","About", "Sign out"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        loadPictureEdit()
        loadUserDetails()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return menuItems.count
        
    }
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        
        
       var myCell = tableView.dequeueReusableCellWithIdentifier("myCell", forIndexPath: indexPath
        ) as! UITableViewCell
        
        myCell.textLabel?.text = menuItems[indexPath.row]
        
        return myCell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        
        switch(indexPath.row){
        
        case 0:
            
            //open main page
            
            var mainPageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("MainPageViewController") as! MainPageViewController
            
            var mainpageNav = UINavigationController(rootViewController: mainPageViewController)
            
            var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            
            appDelegate.drawerContainer!.centerViewController = mainpageNav
            appDelegate.drawerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
            
            
            
            break
        case 1:
            //open about page
            
            var aboutViewController = self.storyboard?.instantiateViewControllerWithIdentifier("AboutViewController") as! AboutViewController
            
            var aboutpageNav = UINavigationController(rootViewController: aboutViewController)
            
            var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            
            appDelegate.drawerContainer!.centerViewController = aboutpageNav
            appDelegate.drawerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
            
            
            break
        
        case 2:
            //perform sign out
            
            //Remove username from NSUserDefaults
            NSUserDefaults.standardUserDefaults().removeObjectForKey("user_name")
            NSUserDefaults.standardUserDefaults().synchronize()
            
            //Show activity indicator
            let spiningActivity = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            
            spiningActivity.labelText = "Sending"
            spiningActivity.detailsLabelText = "Please wait"
            
            //Send instrucctions to log out user in background
            PFUser.logOutInBackground()
            
            //hide spinning activity
            spiningActivity.hide(true)
            
            //Navigate to Protected Page
            let mainStoryBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            
            var signInPage:ViewController = mainStoryBoard.instantiateViewControllerWithIdentifier("ViewController") as! ViewController
            
            var signInPageNav = UINavigationController(rootViewController: signInPage)
            
            var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            
            appDelegate.window?.rootViewController = signInPageNav
            
            break
            
        default:
            println("Option is not handled")
            
        }
        
        
        
    }
    
    @IBAction func editButton(sender: AnyObject) {
        
        var editProfile = self.storyboard?.instantiateViewControllerWithIdentifier("EditProfileViewController") as! EditProfileViewController
        
        editProfile.opener = self
        
        let editProfileNav = UINavigationController(rootViewController: editProfile)
        
        self.presentViewController(editProfileNav, animated: true, completion: nil)
        
        
        
    }
    
    //Refreshing user details
    func loadUserDetails(){
        
        let userFirstName = PFUser.currentUser()?.objectForKey("first_Name") as! String
        
        let userLastName = PFUser.currentUser()?.objectForKey("last_Name") as! String
        
        userFirstNameLabel.text = userFirstName
        userLastNameLabel.text = userLastName
        
        let profilePictureObject = PFUser.currentUser()?.objectForKey("profile_picture") as? PFFile
        
        if(profilePictureObject != nil)
        {
            profilePictureObject!.getDataInBackgroundWithBlock { (imageData:NSData?, error:NSError?) -> Void in
                
                if(imageData != nil)
                {
                    self.userProfilePicture.image = UIImage(data: imageData!)
                }
                
            }
        }
    }
    
    func loadPictureEdit(){
        
        userProfilePicture.layer.borderWidth = 1
        userProfilePicture.layer.masksToBounds = false
        userProfilePicture.layer.borderColor = UIColor.blackColor().CGColor
        userProfilePicture.layer.cornerRadius = userProfilePicture.frame.height/2
        userProfilePicture.clipsToBounds = true
    }
    
}
