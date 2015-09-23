//
//  TweetsViewController.swift
//  TwitterApp
//
//  Created by Andy (Liang) Dong on 9/13/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, TweetCellDelegate {

    var tweets : [Tweet]?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        TwitterClient.sharedInstance.homeTimelineWithParams(nil, completion: { (tweets, error) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
        })
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onLogout(sender: AnyObject) {
        User.currentUser?.logout()
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets?.count ?? 0
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
        
        if let tweet = tweets?[indexPath.row] {
            cell.tweet = tweet
            cell.delegate = self
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //var cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
        tableView.deselectRowAtIndexPath( indexPath, animated: false)
    }


    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "viewTweetDetail" {
            let cell = sender as!  UITableViewCell
            let indexPath = tableView.indexPathForCell(cell)!
            let tweet = tweets?[indexPath.row]
            let tweetDetailViewController = segue.destinationViewController as! TweetDetailViewController
            tweetDetailViewController.tweet = tweet
        } else if segue.identifier == "composeTweet" {
            let dvc = segue.destinationViewController as! UINavigationController
            _ = dvc.topViewController as! ComposeViewController
        } else if segue.identifier == "viewProfileViewSegue" {
            if let pvc = segue.destinationViewController as? ProfileViewController {
                if let button = sender as? UIButton {
                    pvc.user_id = button.tag
                    print(button.tag)
                }
            }
        }
    }
    
    @IBAction func onClickProfileImageView(sender: UIButton) {
        performSegueWithIdentifier("viewProfileViewSegue", sender: sender)
    }
    
    
    func tweetCell(tweetCell: TweetCell, senderTweet: Tweet) {
        print("tweetCell delegate is called")
    }


}
