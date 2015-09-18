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
                println("user login completed")
                self.performSegueWithIdentifier("loginSegue", sender: self)
            } else {
                println("user login error \(error)")
            }
        }
    }
}

