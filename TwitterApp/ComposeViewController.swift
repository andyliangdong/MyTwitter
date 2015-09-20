//
//  ComposeViewController.swift
//  TwitterApp
//
//  Created by Andy (Liang) Dong on 9/20/15.
//  Copyright © 2015 codepath. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {

    @IBOutlet weak var screennameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    
    var user: User? {
        didSet {
            if let user = user {
                profileImageView.setImageWithURL(user.profileImageUrl!)
                usernameLabel.text = user.name
                screennameLabel.text = user.screenname
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        user = User.currentUser
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  
    @IBAction func onTweetButtonAction(sender: UIBarButtonItem) {
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
