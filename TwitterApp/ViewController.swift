//
//  ViewController.swift
//  TwitterApp
//
//  Created by Andy (Liang) Dong on 9/8/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit



class ViewController: UIViewController {
    
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
}

