//
//  UserProfile.swift
//  TwitterApp
//
//  Created by Andy (Liang) Dong on 9/22/15.
//  Copyright © 2015 codepath. All rights reserved.
//

import UIKit

class UserProfile: NSObject {
    var userid: Int?
    var name: String?
    var screenname: String?
    var profileImageUrl: NSURL?
    var backgroundImageUrl: NSURL?
    var tweetsCnt: Int?
    var followingCnt: Int?
    var followerCnt: Int?
    
    
    init(dictionary: NSDictionary) {
        userid = dictionary["id"] as? Int
        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"] as? String
        if let profileImageUrlString = dictionary["profile_image_url_https"] as? String {
            profileImageUrl = NSURL(string: profileImageUrlString)
        }
        if let backgroundImageUrlString = dictionary["profile_background_image_url_https"] as? String {
            backgroundImageUrl = NSURL(string: backgroundImageUrlString)
        }
        tweetsCnt = dictionary["statuses_count"] as? Int
        followingCnt = dictionary["friends_count"] as? Int
        followerCnt = dictionary["followers_count"] as? Int
    }
    
}
