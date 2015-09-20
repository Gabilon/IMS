//
//  CreateInventoryViewController.swift
//  IMS
//
//  Created by Gabriel Bermudez on 9/17/15.
//  Copyright (c) 2015 Gabriel Bermudez. All rights reserved.
//

import UIKit
import Parse

class CreateInventoryViewController: UIViewController
{
    
    @IBOutlet weak var id_Label: UILabel!
    @IBOutlet weak var type_Label: UILabel!
    @IBOutlet weak var name_Label: UILabel!
    
    
    private var labels:[UILabel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labels.append(id_Label)
        labels.append(type_Label)
        labels.append(name_Label)
        
        var query = PFQuery(className: "Publication")
        query.orderByAscending("publication_Name")
        query.selectKeys(["publication_id","publication_Type","publication_Name"]).findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            
            var spacer:CGFloat = 50
            
            if error == nil {
                println("Succesfully retrived \(objects!.count)")
                if let objects = objects as? [PFObject] {
                for x in objects as NSArray {
                    var label = UILabel(frame: CGRectMake(0, 0, 200, 21))
                    label.center = CGPointMake(145,180 + spacer)
                    label.textAlignment = NSTextAlignment.Left
                    label.text = x.objectForKey("publication_id") as? String
                    self.view.addSubview(label)
                    
                    var label1 = UILabel(frame: CGRectMake(0, 0, 200, 21))
                    label1.center = CGPointMake(240, 180 + spacer)
                    label1.textAlignment = NSTextAlignment.Left
                    label1.text = x.objectForKey("publication_Type") as? String
                    self.view.addSubview(label1)
                    
                    var label2 = UILabel(frame: CGRectMake(0, 0, 200, 21))
                    label2.center = CGPointMake(375, 180 + spacer)
                    label2.textAlignment = NSTextAlignment.Left
                    label2.text = x.objectForKey("publication_Name") as? String
                    label2.sizeToFit()
                    self.view.addSubview(label2)
                    
                    spacer = spacer + 50
                    
                    
                    }
                }
                //if let objects = objects as? [PFObject] {
                    //var firstObject = objects[0]
                    //self.id_Label.text = firstObject.objectForKey("publication_id") as? String
                //}
            }
        }
        
        
        
        
        // Do any additional setup after loading the view.
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
    @IBAction func backButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    

}
