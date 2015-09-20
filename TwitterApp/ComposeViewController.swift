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
    @IBOutlet weak var tweetTextField: UITextView!
    
    
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
        var tweetText = tweetTextField.text
        if tweetText.characters.count > 140 {
            tweetText = tweetText.substringToIndex(tweetText.startIndex.advancedBy(140))
        }
        let params = ["status": tweetText]
        TwitterClient.sharedInstance.create_tweet(params) { (response, error) -> () in
            if response != nil {
                print ("tweet created")
                self.dismissViewControllerAnimated(true, completion:nil)
            }
        }
    }
   
    @IBAction func onCancelButton(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
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
