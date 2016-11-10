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

class DeathViewController : UIViewController
{
    override func viewDidLoad()
    {
        
    }
    
    
    @IBAction func sendTweetButtonHandler(sender: AnyObject) {
        tweetVC()
    }
    
    func tweetVC()
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
    
}