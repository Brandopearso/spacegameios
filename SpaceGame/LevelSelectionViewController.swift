//
//  LevelSelectionViewController.swift
//  SpaceGame
//
//  Created by Brandon  Pearson  on 10/23/16.
//  Copyright © 2016 Brandon  Pearson . All rights reserved.
//

import Foundation
import UIKit

class LevelSelectionViewController : UIViewController {
    
    @IBAction func marsButton(sender: AnyObject) {
        
        let create = UIAlertController(title: "Mars Fact", message: "Mars is home to the tallest mountain in the solar system.", preferredStyle: UIAlertControllerStyle.Alert)
        create.addAction(UIAlertAction(title: "Touch anywhere on the screen to begin", style: UIAlertActionStyle.Cancel, handler: {(action: UIAlertAction!) in
            self.moveOn(sender, planet: "mars")}))
        self.presentViewController(create, animated: true, completion: nil)
    }
    
    @IBAction func venusButton(sender: AnyObject) {
        
        var temp:UIViewController = topMostController()
        let create = UIAlertController(title: "Venus Fact", message: "The surface temperature on Venus can reach 471 °C.", preferredStyle: UIAlertControllerStyle.Alert)
        create.addAction(UIAlertAction(title: "Touch anywhere on the screen to begin", style: UIAlertActionStyle.Cancel, handler: nil))
        temp.presentViewController(create, animated: true, completion: nil)
    }
    
    @IBAction func mercuryButton(sender: AnyObject) {
        
        var temp:UIViewController = topMostController()
        let create = UIAlertController(title: "Mercury Fact", message: "Mercury is the smallest planet in the solar system.", preferredStyle: UIAlertControllerStyle.Alert)
        create.addAction(UIAlertAction(title: "Touch anywhere on the screen to begin", style: UIAlertActionStyle.Cancel, handler: {(action: UIAlertAction!) in
            self.moveOn(sender, planet: "mars")}))
        temp.presentViewController(create, animated: true, completion: nil)
    }
    
    @IBAction func earthButton(sender: AnyObject) {
        
        var temp:UIViewController = topMostController()
        let create = UIAlertController(title: "Earth Fact", message: "71% of Earth is covered in water.", preferredStyle: UIAlertControllerStyle.Alert)
        create.addAction(UIAlertAction(title: "Touch anywhere on the screen to begin", style: UIAlertActionStyle.Cancel, handler: {(action: UIAlertAction!) in
            self.moveOn(sender, planet: "mars")}))
        temp.presentViewController(create, animated: true, completion: nil)
    }
    
    @IBAction func jupiterButton(sender: AnyObject) {
        
        var temp:UIViewController = topMostController()
        let create = UIAlertController(title: "Jupiter Fact", message: "Jupiter orbits the Sun once every 11.8 Earth years.", preferredStyle: UIAlertControllerStyle.Alert)
        create.addAction(UIAlertAction(title: "Touch anywhere on the screen to begin", style: UIAlertActionStyle.Cancel, handler: {(action: UIAlertAction!) in
            self.moveOn(sender, planet: "jupiter")}))
        temp.presentViewController(create, animated: true, completion: nil)
    }
    
    @IBAction func saturnButton(sender: AnyObject) {
        
        var temp:UIViewController = topMostController()
        let create = UIAlertController(title: "Saturn Fact", message: "Saturn is the least dense planet in the Solar System.", preferredStyle: UIAlertControllerStyle.Alert)
        create.addAction(UIAlertAction(title: "Touch anywhere on the screen to begin", style: UIAlertActionStyle.Cancel, handler: nil))
        temp.presentViewController(create, animated: true, completion: nil)
    }
    @IBAction func uranusButton(sender: AnyObject) {
        
        var temp:UIViewController = topMostController()
        let create = UIAlertController(title: "Uranus Fact", message: "Uranus hits the coldest temperatures of any planet.", preferredStyle: UIAlertControllerStyle.Alert)
        create.addAction(UIAlertAction(title: "Touch anywhere on the screen to begin", style: UIAlertActionStyle.Cancel, handler: nil))
        temp.presentViewController(create, animated: true, completion: nil)
    }
    
    func topMostController() -> UIViewController {
        var topController: UIViewController = UIApplication.sharedApplication().keyWindow!.rootViewController!
        while (topController.presentedViewController != nil) {
            topController = topController.presentedViewController!
        }
        return topController
    }
    
    @IBAction func neptuneButton(sender: AnyObject) {
        
        var temp:UIViewController = topMostController()
        let create = UIAlertController(title: "Neptune Fact", message: "Neptune has 14 moons.", preferredStyle: UIAlertControllerStyle.Alert)
        create.addAction(UIAlertAction(title: "Touch anywhere on the screen to begin", style: UIAlertActionStyle.Cancel, handler: {(action: UIAlertAction!) in
            self.moveOn(sender, planet: "neptune")}))
        temp.presentViewController(create, animated: true, completion: nil)
        
    }
    
    
    func moveOn(sender: AnyObject, planet:String)
    {
        self.performSegueWithIdentifier(planet, sender: sender)
    }
    override func viewDidLoad()
    {
        
    }
}