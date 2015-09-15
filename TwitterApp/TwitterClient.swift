//
//  TwitterClient.swift
//  TwitterApp
//
//  Created by Andy (Liang) Dong on 9/8/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit

let twitterConsumerKey = "DtzsEUTodw80c95d3A9S6IoDO"
let twitterConsumerSecret = "cgDQOeRWgKXVpx36FcNjOOAvTPkJEI4NOTMHFXhscYbir3ksib"
let twitterBaseURL = NSURL(string: "https://api.twitter.com")

class TwitterClient: BDBOAuth1RequestOperationManager {
   
    var loginCompletion: ((user: User?, error: NSError?) -> ())?
    
    class var sharedInstance : TwitterClient {
        struct Static {
            static let instance =  TwitterClient(baseURL: twitterBaseURL,
                consumerKey : twitterConsumerKey,
                consumerSecret: twitterConsumerSecret)
        }
        return Static.instance
    }
    
    func homeTimelineWithParams(params: NSDictionary?, completion: (tweets: [Tweet]?, error: NSError?) -> ()){
        
        GET("1.1/statuses/home_timeline.json", parameters:
            params, success: { (operation: AFHTTPRequestOperation!, response:AnyObject!) -> Void in
                //println("home_timeline\(response)")
            var tweets = Tweet.tweetsWithArray(response as! [NSDictionary])
//            for tweet in tweets {
//                println("text:\(tweet.text!), created: \(tweet.createdAt!), profileImageURL: \(tweet.user?.profileImageUrl!)")
//            }
            completion(tweets: tweets, error: nil)
        }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
            println("Fail to get home timeline")
            completion(tweets: nil, error: error)
        })
    }
    
    
    func loginWithCompletion(completion: (user:User?, error: NSError?) -> ()) {
        loginCompletion = completion
        
        //fetch request token and redirect to authorization page
        //andydong36://oauth
        let callbackUrl: NSURL = NSURL(string: "andytwitterapp://oauth")!
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token",
            method: "GET", callbackURL: callbackUrl,
            scope: nil, success: {
                (requestToken: BDBOAuth1Credential!) -> Void in
                println("Got the request token")
                var authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
                UIApplication.sharedApplication().openURL(authURL!)
            }){ (error: NSError!) -> Void in
                println("Failed to get request token")
                self.loginCompletion?(user: nil, error: error)
        }
    }

    
    func openURL(url: NSURL) {
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: BDBOAuth1Credential(queryString: url.query), success: { (accessToken:BDBOAuth1Credential!) -> Void in
            println("Got the access token")
            TwitterClient.sharedInstance.requestSerializer.saveAccessToken(accessToken)
            TwitterClient.sharedInstance.GET("1.1/account/verify_credentials.json", parameters: nil, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                //println(response)
                var user = User(dictionary: response as! NSDictionary)
                User.currentUser = user
                println("user:\(user.name)")
                self.loginCompletion?(user: user, error: nil)
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println("Fail to get verified credentials")
                self.loginCompletion?(user: nil, error: error)
            })
            
            
         }) { (error: NSError!) -> Void in
            println("Fail to get the access token")
            self.loginCompletion?(user: nil, error: error)
        }

    }
}
