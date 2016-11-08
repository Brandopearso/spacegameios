//
//  GameViewController.swift
//  SpaceGame
//
//  Created by Brandon  Pearson  on 9/12/16.
//  Copyright (c) 2016 Brandon  Pearson . All rights reserved.
//

import UIKit
import SpriteKit

class MarsViewController: UIViewController, DeathSceneDelegate {
    
    func launchViewController(scene: SKScene) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = mainStoryboard.instantiateViewControllerWithIdentifier("Death") as! DeathViewController
        presentViewController(vc, animated: true, completion: nil)
        // note that you don't need to go through a bunch of optionals to call presentViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let scene = MarsScene(fileNamed:"MarsScene") {
            // Configure the view.
            let skView = self.view as! SKView
            skView.showsFPS = true
            skView.showsNodeCount = true
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .AspectFill
            scene.collisionDelegate = self
            skView.presentScene(scene)
        }
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return .AllButUpsideDown
        } else {
            return .All
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
