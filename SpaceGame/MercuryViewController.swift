//
//  GameViewController.swift
//  SpaceGame
//
//  Created by Brandon  Pearson  on 9/12/16.
//  Copyright (c) 2016 Brandon  Pearson . All rights reserved.
//

import UIKit
import SpriteKit

struct physicsCategory {
    
    static let enemy: UInt32 = 1
    static let bullet: UInt32 = 2
    static let player: UInt32 = 4
    static let powerup: UInt32 = 8
}

class MercuryViewController: UIViewController, DeathSceneDelegate {
    
    var level_name:String = ""
        
    func launchViewController(_ scene: SKScene) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "Death") as! DeathViewController
        present(vc, animated: true, completion: nil)
        // note that you don't need to go through a bunch of optionals to call presentViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        if let scene = MercuryScene(fileNamed:"MercuryScene") {
            // Configure the view.
            let skView = self.view as! SKView
            skView.showsFPS = true
            skView.showsNodeCount = true
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .aspectFill
            scene.collisionDelegate = self
            scene.level_name = self.level_name
            skView.presentScene(scene)
        }
    }
    
    override var shouldAutorotate : Bool {
        return true
    }
    
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
}
