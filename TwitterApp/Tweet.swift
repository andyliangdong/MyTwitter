//
//  Tweet.swift
//  TwitterApp
//
//  Created by Andy (Liang) Dong on 9/12/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit


class Tweet: NSObject {
    var user: User?
    var id : Int?
    var text: String?
    var createdAtString: String?
    var createdAt: NSDate?
    var urlsInText: [NSURL]?
    var retweetCnt: Int?
    var favoriteCnt: Int?
    var urls: [NSURL]?
    var retweet : Tweet?
    var isFavorited: Bool?
    var isRetweeted: Bool?
    
    
    init(dictionary: NSDictionary) {
        user = User(dictionary: dictionary["user"] as! NSDictionary)
        id = dictionary["id"] as? Int
        text = dictionary["text"] as? String
        isFavorited = dictionary["favorited"] as? Bool
        isRetweeted = dictionary["retweeted"] as? Bool
        retweetCnt = dictionary["retweet_count"] as? Int
        favoriteCnt = dictionary["favorite_count"] as? Int
        
        createdAtString = dictionary["created_at"] as? String
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        createdAt = formatter.dateFromString(createdAtString!)
        
//        if let _urls = dictionary["entities"]?["urls"] as? [String] {
//            urls = [NSURL]()
//            for _url in _urls {
//                let _nsurl = NSURL(fileURLWithPath: _url)
//                urls?.append(_nsurl)
//            }
//        }
        
        if let retweetStr = dictionary["retweeted_status"] as? NSDictionary {
            retweet = Tweet(dictionary: retweetStr)
        }
    }
    
    class func tweetsWithArray(array: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in array {
            tweets.append(Tweet(dictionary: dictionary))
        }
        return tweets
    }
    
    
}
