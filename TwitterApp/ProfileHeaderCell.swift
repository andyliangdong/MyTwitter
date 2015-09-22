//
//  ProfileHeaderCell.swift
//  TwitterApp
//
//  Created by Andy (Liang) Dong on 9/22/15.
//  Copyright © 2015 codepath. All rights reserved.
//

import UIKit

class ProfileHeaderCell: UITableViewCell {

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screennameLabel: UILabel!
    @IBOutlet weak var tweetCntLabel: UILabel!
    @IBOutlet weak var followingCntLabel: UILabel!
    @IBOutlet weak var followerCntLabel: UILabel!
    
    var userProfile: UserProfile! {
        didSet {
            
            backgroundImageView.setImageWithURL(userProfile.backgroundImageUrl)
            profileImageView.setImageWithURL(userProfile.profileImageUrl)
            nameLabel.text = userProfile.name
            screennameLabel.text = userProfile.screenname
            tweetCntLabel.text = "\(userProfile.tweetsCnt!)"
            followingCntLabel.text = "\(userProfile.followingCnt!)"
            followerCntLabel.text = "\(userProfile.followerCnt!)"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profileImageView.layer.cornerRadius = 3
        profileImageView.clipsToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
