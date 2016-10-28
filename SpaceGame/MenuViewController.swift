//
//  MenuViewController.swift
//  SpaceGame
//
//  Created by Arjun Gopisetty on 10/25/16.
//  Copyright © 2016 Brandon  Pearson . All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let defaults = NSUserDefaults.standardUserDefaults()
        if let music = defaults.objectForKey("backgroundMusic") as? Bool {
            // Its already set
            print(music)
        } else {
            defaults.setBool(true, forKey: "backgroundMusic")
        }
        defaults.synchronize()
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
    override func shouldAutorotate() -> Bool {
        return false;
    }

}
