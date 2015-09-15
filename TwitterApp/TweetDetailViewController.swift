//
//  TweetDetailViewController.swift
//  TwitterApp
//
//  Created by Andy (Liang) Dong on 9/14/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit

class TweetDetailViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var retweetCntLabel: UILabel!
    @IBOutlet weak var favoriteCntLabel: UILabel!
    @IBOutlet weak var retweetedImageView: UIImageView!
    @IBOutlet weak var retweetedNameLabel: UILabel!
    
    var user : User! {
        didSet {
            nameLabel.text = user?.name
            if let screenname = user?.screenname {
                screenNameLabel.text = "@\(screenname)"
            }
            if let profileImageUrl = user?.profileImageUrl {
                profileImageView.setImageWithURL(profileImageUrl)
            }
            if let createdAt = tweet?.createdAt {
                //tweetAgeLabel.text = elapsedTime(createdAt)
            }
        }
    }
    
    var tweet : Tweet?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if (tweet?.retweet == nil) {
            tweetTextLabel.text = tweet?.text
            retweetCntLabel.text = "\(tweet?.retweetCnt!)"
            favoriteCntLabel.text = "\(tweet?.favoriteCnt!)"
            user = tweet?.user
            retweetedNameLabel.hidden = true
            retweetedImageView.hidden = true
        } else {
            user = tweet?.retweet!.user
            if let retweetUsername = tweet?.user?.name {
                tweetTextLabel.text = tweet?.retweet?.text
                if let retCnt = tweet?.retweet?.retweetCnt {
                    retweetCntLabel.text = "\(retCnt)"
                }
                if let favCnt = tweet?.retweet?.favoriteCnt {
                    favoriteCntLabel.text = "\(favCnt)"
                }
                retweetedNameLabel.hidden = false
                retweetedImageView.hidden = false
                retweetedNameLabel.text = "\(retweetUsername) Retweeted"
            }
        }
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

}
