//
//  AppDelegate.swift
//  IMS
//
//  Created by Gabriel Bermudez on 8/20/15.
//  Copyright (c) 2015 Gabriel Bermudez. All rights reserved.
//

import UIKit
import Parse
import Bolts

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var drawerContainer: MMDrawerController?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        Parse.enableLocalDatastore()
        
        // Initialize Parse.
        Parse.setApplicationId("10RhLvgLglDSCgXKU92Z7Jcz8wNxs2gBtvJApgr8",
            clientKey: "ybLtysuFVfE2rmrbggl8bPw3wGwjVoHaKwQCq42y")
        
        // [Optional] Track statistics around application opens.
        //PFAnalytics.trackAppOpenedWithLaunchOptions(launchOptions)
        
        //PFUser.logOut()
        
        buildUserInterface()
        
        
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func buildUserInterface(){
        let userName:String? = NSUserDefaults.standardUserDefaults().stringForKey("user_name")
        
        if (userName != nil){
            
            //Navigate to Protected Main Page
            let mainStoryBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            
            //Instantiating ViewControllers to the main protected page
            var mainPage:MainPageViewController = mainStoryBoard.instantiateViewControllerWithIdentifier("MainPageViewController") as! MainPageViewController
            
            var leftSideMenu:LeftSideViewController = mainStoryBoard.instantiateViewControllerWithIdentifier("LeftSideViewController") as! LeftSideViewController
            
            var rightSideMenu:RightSideViewController = mainStoryBoard.instantiateViewControllerWithIdentifier("RightSideViewController") as! RightSideViewController
            
            //Wrap into Navigation controllers
            var mainPageNav = UINavigationController(rootViewController: mainPage)
            var leftSideMenuNav = UINavigationController(rootViewController: leftSideMenu)
            var rightSideMenuNav = UINavigationController(rootViewController: rightSideMenu)
            
            drawerContainer = MMDrawerController(centerViewController: mainPageNav, leftDrawerViewController: leftSideMenuNav, rightDrawerViewController: rightSideMenuNav)
            
            drawerContainer!.openDrawerGestureModeMask = MMOpenDrawerGestureMode.PanningCenterView
            drawerContainer!.closeDrawerGestureModeMask = MMCloseDrawerGestureMode.PanningCenterView
            
            window?.rootViewController = drawerContainer
        }
    }


}

