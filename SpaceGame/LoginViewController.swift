//
//  LoginViewController.swift
//  SpaceGame
//
//  Created by yu zhong on 11/28/16.
//  Copyright © 2016 Brandon  Pearson . All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class LoginViewController: UIViewController
{
    var ref: FIRDatabaseReference?
    
    @IBOutlet weak var Email: UITextField!
    
    @IBOutlet weak var Password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = FIRDatabase.database().reference()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func Login(sender: AnyObject) {
        FIRAuth.auth()?.signInWithEmail(Email.text!, password: Password.text!, completion: {
            user, error in
            
            if error != nil
            {
                let failed = UIAlertController(title: "Error", message: "The password doesn't match with the account name", preferredStyle: UIAlertControllerStyle.Alert)
                failed.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil))
                self.presentViewController(failed, animated: true, completion: nil)
                
            }
            else
            {
                
                let logging = UIAlertController(title: "Log in", message: "Login Successed", preferredStyle: UIAlertControllerStyle.Alert)
                logging.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {action in self.moveOn(sender)}))
                self.presentViewController(logging, animated: true, completion: nil)
                
            }
        })
    }
    
    
    @IBAction func CreateAcc(sender: AnyObject)
    {
        FIRAuth.auth()?.createUserWithEmail(Email.text!, password: Password.text!, completion: {
        user, error in
        
        if error != nil
        {
            let failed = UIAlertController(title: "Error", message: "Account format wrong/email already registered", preferredStyle: UIAlertControllerStyle.Alert)
            failed.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil))
            self.presentViewController(failed, animated: true, completion: nil)
        }
        else
        {
            var email = self.Email.text!.lowercaseString;
            email = email.stringByReplacingOccurrencesOfString(".", withString: ",")
            self.ref?.child("Users").child(email).child("Highscore").setValue(0)
            let create = UIAlertController(title: "create", message: "Account created", preferredStyle: UIAlertControllerStyle.Alert)
            create.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil))
            self.presentViewController(create, animated: true, completion: nil)
        }
        })
    }
    
    func moveOn(sender: AnyObject)
    {
        self.performSegueWithIdentifier("login", sender: sender)
    }
}
