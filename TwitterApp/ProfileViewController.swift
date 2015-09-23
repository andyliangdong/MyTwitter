//
//  ProfileViewController.swift
//  TwitterApp
//
//  Created by Andy (Liang) Dong on 9/20/15.
//  Copyright © 2015 codepath. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var userProfile : UserProfile?
    var tweets : [Tweet]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let user = User.currentUser!
        let params = ["user_id":user.id!, "screen_name": user.screenname!]
        TwitterClient.sharedInstance.showUserProfileWithParams(params) { (userProfile, error) -> () in
            self.userProfile = userProfile
            self.tableView.reloadData()
        }
        
        TwitterClient.sharedInstance.userTimelineWithParams(params) { (tweets, error) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
        }
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets?.count ?? 0
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 180
    }
    
   
    func tableView(tableView: UITableView,  viewForHeaderInSection section: Int) -> UIView? {
        let  headerCell = tableView.dequeueReusableCellWithIdentifier("ProfileHeaderCell") as! ProfileHeaderCell
        if let profile = userProfile {
            headerCell.userProfile = profile
        }
        return headerCell
    }
    

    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ProfileTweetCell", forIndexPath: indexPath) as! ProfileTweetCell
        if let tweet = tweets?[indexPath.row] {
            cell.tweet = tweet
        }
        return cell
    }


    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "viewProfileTweetDetail" {
            let cell = sender as!  UITableViewCell
            let indexPath = tableView.indexPathForCell(cell)!
            let tweet = tweets?[indexPath.row]
            let tweetDetailViewController = segue.destinationViewController as! TweetDetailViewController
            tweetDetailViewController.tweet = tweet
        }
    }


}
