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
        if let profileImageUrlString = dictionary["profile_image_url_https"] as? String {
//            var str = profileImageUrlString
//            let range = Range<String.Index>(start: str.startIndex, end: str.startIndex.advancedBy(4))
//            str.replaceRange(range,  with: "https")
            profileImageUrl = NSURL(string: profileImageUrlString)
            //print(profileImageUrl)
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
                let data = NSUserDefaults.standardUserDefaults().objectForKey(currentUserKey) as? NSData
                if let userData = data {
                    let dictionary = (try? NSJSONSerialization.JSONObjectWithData(userData, options: [])) as? NSDictionary
                    _currentUser = User(dictionary: dictionary!)
                }
            }
            return _currentUser
        }
        set(user) {
            _currentUser = user
            if (_currentUser != nil) {
                let data = try? NSJSONSerialization.dataWithJSONObject(user!.dictionary, options: [])
                NSUserDefaults.standardUserDefaults().setObject(data, forKey: currentUserKey)
            } else {
                NSUserDefaults.standardUserDefaults().setObject(nil, forKey: currentUserKey)
                
            }
            NSUserDefaults.standardUserDefaults().synchronize()
        }
        
    }
}
