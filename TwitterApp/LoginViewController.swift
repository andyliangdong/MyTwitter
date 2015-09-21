//
//  ViewController.swift
//  TwitterApp
//
//  Created by Andy (Liang) Dong on 9/8/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit



class LoginViewController: UIViewController {
    
    @IBAction func onLogin(sender: AnyObject) {
        TwitterClient.sharedInstance.loginWithCompletion() {
            (user: User?, error: NSError?) in
            if user != nil {
                print("user login completed")
                self.performSegueWithIdentifier("loginSegue", sender: self)
            } else {
                print("user login error \(error)")
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "loginSegue" {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let hamburgerViewController = segue.destinationViewController as! HamburgerViewController
            let menuViewController = storyboard.instantiateViewControllerWithIdentifier("MenuViewController") as! MenuViewController
            menuViewController.hamburgerViewController = hamburgerViewController
            hamburgerViewController.menuViewController = menuViewController
        }
    }

}

