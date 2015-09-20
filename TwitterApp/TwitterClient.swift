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
        GET("1.1/statuses/home_timeline.json", parameters: params, success: { (operation: AFHTTPRequestOperation!, response:AnyObject!) -> Void in
            let tweets = Tweet.tweetsWithArray(response as! [NSDictionary])
            completion(tweets: tweets, error: nil)
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                print("Fail to get home timeline")
                completion(tweets: nil, error: error)
        })
    }
    
    func favorite_create(id: Int, completion: (response: AnyObject?, error: NSError?) -> ()){
        let params = ["id": id]
        POST("1.1/favorites/create.json", parameters: params, success: { (operation: AFHTTPRequestOperation!, response:AnyObject!) -> Void in
            print("Successfully favorited")
            completion(response: response, error:nil)
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                print("Fail to favorite")
                completion(response: nil, error: error)
        })
    }
    
    func retweet_id(id: Int, completion: (response: AnyObject?, error: NSError?) -> ()) {
        let params = ["id": id]
        POST("1.1/statuses/retweet/\(id).json", parameters: params, success: { ( operation: AFHTTPRequestOperation!,
            response: AnyObject!) -> Void in
            print("Successfully retweet id:\(id)")
            completion(response: response, error: nil)
            }, failure: {(operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                print("Fail to retweet id:\(id)")
                completion(response: nil, error: error)
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
                print("Got the request token")
                let authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
                UIApplication.sharedApplication().openURL(authURL!)
            }){ (error: NSError!) -> Void in
                print("Failed to get request token")
                self.loginCompletion?(user: nil, error: error)
        }
    }

    
    func openURL(url: NSURL) {
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: BDBOAuth1Credential(queryString: url.query), success: { (accessToken:BDBOAuth1Credential!) -> Void in
            print("Got the access token")
            TwitterClient.sharedInstance.requestSerializer.saveAccessToken(accessToken)
            TwitterClient.sharedInstance.GET("1.1/account/verify_credentials.json", parameters: nil, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                //println(response)
                let user = User(dictionary: response as! NSDictionary)
                User.currentUser = user
                print("user:\(user.name)")
                self.loginCompletion?(user: user, error: nil)
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                print("Fail to get verified credentials")
                self.loginCompletion?(user: nil, error: error)
            })
            
            
         }) { (error: NSError!) -> Void in
            print("Fail to get the access token")
            self.loginCompletion?(user: nil, error: error)
        }

    }
}
