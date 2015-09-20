//
//  TweetCell.swift
//  TwitterApp
//
//  Created by Andy (Liang) Dong on 9/13/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit



@objc protocol TweetCellDelegate {
    optional func tweetCell(tweetCell: TweetCell, senderTweet: Tweet)
}




class TweetCell: UITableViewCell {

    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var tweetAgeLabel: UILabel!
    @IBOutlet weak var retweetedImageView: UIImageView!
    @IBOutlet weak var retweetedNameLabel: UILabel!
    @IBOutlet weak var textUrlImageView: UIView!
    @IBOutlet weak var retweetCntLabel: UILabel!
    @IBOutlet weak var favoriteCntLabel: UILabel!
    
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    lazy var formatter = NSDateFormatter()
    
    weak var delegate: TweetCellDelegate?
    
    var user : User! {
        didSet {
            nameLabel.text = user?.name
            if let screenname = user?.screenname {
                screenNameLabel.text = "@\(screenname)"
            }
            if let profileImageUrl = user?.profileImageUrl {
                profileImageView.setImageWithURL(profileImageUrl)
            }    
        }
    }
    
    var tweet : Tweet! {
        didSet {
            if (tweet.retweet == nil) {
                tweetTextLabel.text = tweet.text
                retweetCntLabel.text = "\(tweet.retweetCnt!)"
                favoriteCntLabel.text = "\(tweet.favoriteCnt!)"
                user = tweet.user
                retweetedNameLabel.hidden = true
                retweetedImageView.hidden = true
            } else {
                user = tweet.retweet!.user
                if let retweetUsername = tweet.user?.name {
                    tweetTextLabel.text = tweet.retweet?.text
                    if let retCnt = tweet.retweet?.retweetCnt {
                        retweetCntLabel.text = "\(retCnt)"
                    }
                    if let favCnt = tweet.retweet?.favoriteCnt {
                        favoriteCntLabel.text = "\(favCnt)"
                    }
                    retweetedNameLabel.hidden = false
                    retweetedImageView.hidden = false
                    retweetedNameLabel.text = "\(retweetUsername) Retweeted"
                }
            }
            if let createdAt = tweet.createdAt {
                tweetAgeLabel.text = elapsedTime(createdAt)
            }
            
            if tweet.isFavorited! == true {
                self.favoriteButton.setImage(UIImage(named:"favorite_on"), forState: UIControlState.Normal)
            } else {
                self.favoriteButton.setImage(UIImage(named:"favorite"), forState: UIControlState.Normal)
            }
            
            if tweet.isRetweeted! == true {
                self.retweetButton.setImage(UIImage(named:"retweet_on"), forState: UIControlState.Normal)
            } else {
                self.retweetButton.setImage(UIImage(named:"retweet"), forState: UIControlState.Normal)
            }
        }
    }
    
    
    @IBAction func onFavoriteButton(sender: UIButton) {
        if let id = tweet.id  {
            if tweet!.isFavorited == false {
                self.favoriteButton.setImage(UIImage(named:"favorite_on"), forState: UIControlState.Normal)
                self.tweet!.favoriteCnt! +=  1
                self.favoriteCntLabel.text = "\(self.tweet!.favoriteCnt!)"
                
                TwitterClient.sharedInstance.favorite_create(id, completion: { (response, error) -> () in
                    if response != nil {
                        self.tweet!.isFavorited = true
                    } else if error != nil {
                        print("error:\(error)")
                        self.favoriteButton.setImage(UIImage(named:"favorite"), forState: UIControlState.Normal)
                    }
                })
            }
        }
    }
    
    @IBAction func onRetweetButton(sender: UIButton) {
    }
    
    
    func elapsedTime(createdAt : NSDate) -> String {
        let elapsed = Int(NSDate().timeIntervalSinceDate(createdAt))
        var tweetAge : String
        if(elapsed < 60) {
            tweetAge = "\(elapsed)s"
        } else if (elapsed < 3600) {
            tweetAge = "\(elapsed/60)m"
        } else if (elapsed < 86400) {
            tweetAge =  "\(elapsed/3600)h"
        } else if (elapsed < 604800) {
            tweetAge =  "\(elapsed/86400)d"
        } else {
            formatter.dateStyle = NSDateFormatterStyle.ShortStyle
            tweetAge =  formatter.stringFromDate(createdAt)
        }
        
        return tweetAge
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        profileImageView.layer.cornerRadius = 3
        profileImageView.clipsToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
