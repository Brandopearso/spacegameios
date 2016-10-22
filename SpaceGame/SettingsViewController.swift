//
//  SettingsViewController.swift
//  SpaceGame
//
//  Created by Arjun Gopisetty on 10/22/16.
//  Copyright © 2016 Brandon  Pearson . All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var musicToggleButton: UIButton!
    @IBOutlet weak var sfxToggleButton: UIButton!
    
    private var musicToggle:Bool?
    private var sfxToggle:Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // TODO: Read music/sfx settings from player settings and set button texts. Set bool values.
        musicToggle = true
        sfxToggle = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func musicToggleButtonHandler(sender: AnyObject) {
        if (musicToggle! == true) {
            musicToggle = false
            musicToggleButton.setTitle("Music Off", forState: .Normal)
        } else {
            musicToggle = true
            musicToggleButton.setTitle("Music On", forState: .Normal)
            
        }
    }
    
    @IBAction func sfxToggleButtonHandler(sender: AnyObject) {
        if (sfxToggle! == true) {
            sfxToggle = false
            sfxToggleButton.setTitle("SFX Off", forState: .Normal)
        } else {
            sfxToggle = true
            sfxToggleButton.setTitle("SFX On", forState: .Normal)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
