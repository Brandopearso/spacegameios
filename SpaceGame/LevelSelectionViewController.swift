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
    
    var level_name:String = ""
    
    @IBAction func mercury(_ sender: UIButton) {
        
        level_name = "mercury"
    }
    
    @IBAction func venus(_ sender: UIButton) {
        
        level_name = "venus"
    }
    
    override func viewDidLoad()
    {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let nextScene =  segue.destination as! GameViewController
        
        if (segue.identifier == "mercury") {
            
            level_name = "mercury"
        }
        else if (segue.identifier == "venus") {
            
            level_name = "venus"
        }
        else if (segue.identifier == "earth") {
            
            level_name = "earth"
        }
        else if (segue.identifier == "mars") {
            
            level_name = "mars"
        }
        else if (segue.identifier == "jupiter") {
            
            level_name = "jupiter"
        }
        else if (segue.identifier == "saturn") {
            
            level_name = "saturn"
        }
        else if (segue.identifier == "uranus"){
            
            level_name = "uranus"
        }
        else if (segue.identifier == "neptune") {
            
            level_name = "neptune"
        }
        
        // Pass the selected object to the new view controller.
        nextScene.level_name = self.level_name
        
    }
}
