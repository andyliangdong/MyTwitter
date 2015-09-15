//
//  User.swift
//  TwitterApp
//
//  Created by Andy (Liang) Dong on 9/12/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit

var _currentUser : User?
let currentUserKey = "kCurrentUserKey"
let userDidLoginNotification = "userDidLoginNotification"
let userDidLogoutNotification = "userDidLogoutNotification"

class User: NSObject {
    var name: String?
    var screenname: String?
    var profileImageUrl: NSURL?
    var tagline: String?
    var dictionary: NSDictionary
    
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
        
        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"] as? String
        if let profileImageUrlString = dictionary["profile_image_url"] as? String {
            profileImageUrl = NSURL(string: profileImageUrlString)
        }
        
        tagline = dictionary["description"] as? String
    }
    
    
    func logout() {
        User.currentUser = nil
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        NSNotificationCenter.defaultCenter().postNotificationName( userDidLogoutNotification, object:nil)
    }
    
    class var currentUser: User? {
        get {
            if _currentUser == nil {
                var data = NSUserDefaults.standardUserDefaults().objectForKey(currentUserKey) as? NSData
                if let userData = data {
                    var dictionary = NSJSONSerialization.JSONObjectWithData(userData, options: nil, error: nil) as? NSDictionary
                    _currentUser = User(dictionary: dictionary!)
                }
            }
            return _currentUser
        }
        set(user) {
            _currentUser = user
            if (_currentUser != nil) {
                var data = NSJSONSerialization.dataWithJSONObject(user!.dictionary, options: nil, error: nil )
                NSUserDefaults.standardUserDefaults().setObject(data, forKey: currentUserKey)
            } else {
                NSUserDefaults.standardUserDefaults().setObject(nil, forKey: currentUserKey)
                
            }
            NSUserDefaults.standardUserDefaults().synchronize()
        }
        
    }
}
