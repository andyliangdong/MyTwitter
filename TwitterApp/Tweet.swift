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
    var text: String?
    var createdAtString: String?
    var createdAt: NSDate?
    var urlsInText: [NSURL]?
    var retweetCnt: Int?
    var favoriteCnt: Int?
    var urls: [NSURL]?
    var retweet : Tweet?
    
    
    init(dictionary: NSDictionary) {
        user = User(dictionary: dictionary["user"] as! NSDictionary)
        text = dictionary["text"] as? String
        
        retweetCnt = dictionary["retweet_count"] as? Int
        favoriteCnt = dictionary["favorite_count"] as? Int
        createdAtString = dictionary["created_at"] as? String
        
        var formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        createdAt = formatter.dateFromString(createdAtString!)
        
        if let _urls = dictionary["entities"]?["urls"] as? [String] {
            urls = [NSURL]()
            for _url in _urls {
                if let _nsurl = NSURL(fileURLWithPath: _url) {
                    println(_url)
                    urls?.append(_nsurl)
                }
            }
        }
        
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
