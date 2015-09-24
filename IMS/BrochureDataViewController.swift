//
//  BrochureDataViewController.swift
//  IMS
//
//  Created by Gabriel Bermudez on 9/20/15.
//  Copyright © 2015 Gabriel Bermudez. All rights reserved.
//

import UIKit
import Parse
import Bolts


class BrochureDataViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
    let brochureQuery = PFQuery(className: "Publication")
        .fromLocalDatastore().ignoreACLs()
        brochureQuery.limit = 50
        brochureQuery.whereKey("publication_Type", equalTo: "Brochure")
        brochureQuery.findObjectsInBackgroundWithBlock { (brochureObject, error) -> Void in
            if error == nil {
                print("Brochures found: \(brochureObject!.count)")
            
                
                var spacer:CGFloat = 50
                
                if let objects = brochureObject {
                    
                    //for every object in variable objects as an Array, the code follows:
                    for x in objects as NSArray {
                        
                        //Creating labels and looking for the objectforKey pub_id, pub_type and pub_Name
                        let label = UILabel(frame: CGRectMake(0, 0, 200, 21))
                        label.center = CGPointMake(145,180 + spacer)
                        label.textAlignment = NSTextAlignment.Left
                        label.text = x.objectForKey("publication_id") as? String
                        self.view.addSubview(label)
                        
                        let label1 = UILabel(frame: CGRectMake(0, 0, 200, 21))
                        label1.center = CGPointMake(240, 180 + spacer)
                        label1.textAlignment = NSTextAlignment.Left
                        label1.text = x.objectForKey("publication_Type") as? String
                        self.view.addSubview(label1)
                        
                        let label2 = UILabel(frame: CGRectMake(0, 0, 200, 21))
                        label2.center = CGPointMake(375, 180 + spacer)
                        label2.textAlignment = NSTextAlignment.Left
                        label2.text = x.objectForKey("publication_Name") as? String
                        label2.sizeToFit()
                        self.view.addSubview(label2)
                        
                        //variable spacer = this creates a space between all labels. (very important)
                        spacer = spacer + 50
                        
                        
                    }
                }

            }
    }
        
            
}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func cancelButton(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}
