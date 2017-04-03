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
    
    
    @IBAction func sendTweetButtonHandler(_ sender: AnyObject) {
        tweetSLVC()
    }
    
    @IBAction func sendFbButtonHandler(_ sender: AnyObject) {
        facebookSLVC()
    }
    
    func tweetSLVC()
    {
        let highscore = UserDefaults.standard.value(forKey: "Highscore") as! NSInteger!
        
        if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter){
            let twitterController:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            twitterController.setInitialText("My high score in space game: " + String(describing: highscore) + ". Beat my score!")
            self.present(twitterController, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Twitter Account", message: "Please login to your Twitter account.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func facebookSLVC() {
        let highscore = UserDefaults.standard.value(forKey: "Highscore") as! NSInteger!
        
        if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeFacebook){
            let facebookController:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            facebookController.setInitialText("My high score in space game: " + String(describing: highscore) + ". Beat my score!")
            self.present(facebookController, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Facebook Account", message: "Please login to your Facebook account.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}
