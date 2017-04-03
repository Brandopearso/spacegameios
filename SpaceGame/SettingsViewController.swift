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
    
    fileprivate var musicToggle:Bool!
    fileprivate var sfxToggle:Bool!
    
    fileprivate var defaults:UserDefaults!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // TODO: Read music/sfx settings from player settings and set button texts. Set bool values.
        sfxToggle = true
        musicToggle = true
        defaults = UserDefaults.standard
        if (defaults.bool(forKey: "backgroundMusic")) {
            musicToggle = true
            musicToggleButton.setTitle("Music On", for: UIControlState())
        } else {
            musicToggle = false
            musicToggleButton.setTitle("Music Off", for: UIControlState())
        }
        if (defaults.bool(forKey: "sfx")) {
            sfxToggle = true
            sfxToggleButton.setTitle("SFX On", for: UIControlState())
        } else {
            sfxToggle = false
            sfxToggleButton.setTitle("SFX Off", for: UIControlState())
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func musicToggleButtonHandler(_ sender: AnyObject) {
        if (musicToggle! == true) {
            musicToggle = false
            musicToggleButton.setTitle("Music Off", for: UIControlState())
            defaults.set(false, forKey: "backgroundMusic")
            
        } else {
            musicToggle = true
            musicToggleButton.setTitle("Music On", for: UIControlState())
            defaults.set(true, forKey: "backgroundMusic")
        }
        defaults.synchronize()
    }
    
    
    
    @IBAction func sfxToggleButtonHandler(_ sender: AnyObject) {
        if (sfxToggle! == true) {
            sfxToggle = false
            sfxToggleButton.setTitle("SFX Off", for: UIControlState())
            defaults.set(false, forKey: "sfx")
        } else {
            sfxToggle = true
            sfxToggleButton.setTitle("SFX On", for: UIControlState())
            defaults.set(true, forKey: "sfx")
        }
    }
    
    override var shouldAutorotate : Bool {
        return false;
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
