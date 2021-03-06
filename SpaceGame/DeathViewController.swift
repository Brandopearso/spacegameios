//
//  DeathViewController.swift
//  SpaceGame
//
//  Created by Brandon  Pearson  on 11/8/16.
//  Copyright © 2016 Brandon  Pearson . All rights reserved.
//

import Foundation
import UIKit
import SpriteKit
import Social
import Accounts
import Firebase
import FirebaseDatabase

class DeathViewController : UIViewController
{
    var ref: FIRDatabaseReference!
    var refHandle: UInt!
    
    override func viewDidLoad()
    {
        ref = FIRDatabase.database().reference().child("Users")
        let highscore = NSUserDefaults.standardUserDefaults().valueForKey("Highscore") as! NSInteger!
        var email = (FIRAuth.auth()?.currentUser?.email)!
        email = email.stringByReplacingOccurrencesOfString(".", withString: ",")
        ref = ref.child(email)
        var scorelist = [NSInteger]()
        ref.observeEventType(.Value, withBlock:  { (snapshot) in
            if snapshot.value is NSNull{
                
            }
            else
            {
                if let score = snapshot.value!.objectForKey("Highscore") as? Int
                {
                    if(highscore > score)
                    {
                        self.ref?.child("Highscore").setValue(highscore)
                    }
                }
                else
                {
                    print("it was nil")
                }
            }
            
        })
        {(error) in
            print("error")
        }
    }
    
    
    @IBAction func sendTweetButtonHandler(sender: AnyObject) {
        tweetSLVC()
    }
    
    @IBAction func sendFbButtonHandler(sender: AnyObject) {
        facebookSLVC()
    }
    
    func tweetSLVC()
    {
        let highscore = NSUserDefaults.standardUserDefaults().valueForKey("Highscore") as! NSInteger!
        
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter){
            let twitterController:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            twitterController.setInitialText("My high score in space game: " + String(highscore) + ". Beat my score!")
            self.presentViewController(twitterController, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Twitter Account", message: "Please login to your Twitter account.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    func facebookSLVC() {
        let highscore = NSUserDefaults.standardUserDefaults().valueForKey("Highscore") as! NSInteger!
        
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook){
            let facebookController:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            facebookController.setInitialText("My high score in space game: " + String(highscore) + ". Beat my score!")
            self.presentViewController(facebookController, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Facebook Account", message: "Please login to your Facebook account.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
}