//
//  AboutViewController.swift
//  IMS
//
//  Created by Gabriel Bermudez on 9/12/15.
//  Copyright (c) 2015 Gabriel Bermudez. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

    @IBOutlet weak var giveNoteLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        giveNoteLabel.minimumScaleFactor = 0.5
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func leftSideButton(sender: AnyObject) {
        
        let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        appDelegate.drawerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
    }

    @IBAction func rightSideButton(sender: AnyObject) {
        
        let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        appDelegate.drawerContainer!.toggleDrawerSide(MMDrawerSide.Right, animated: true, completion: nil)
    }
    

}
