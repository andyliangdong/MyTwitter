//
//  MentionsViewController.swift
//  TwitterApp
//
//  Created by Andy (Liang) Dong on 9/20/15.
//  Copyright © 2015 codepath. All rights reserved.
//

import UIKit

class MentionsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tweets: [Tweet]?

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        TwitterClient.sharedInstance.mentionsTimelineWithParams(nil, completion: { (tweets, error) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
        })

        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        
        //tableView.registerClass(TweetCell.self, forCellReuseIdentifier: "TweetCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets?.count ?? 0
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MentionTweetCell", forIndexPath: indexPath) as! MentionTweetCell
        if let tweet = tweets?[indexPath.row] {
            cell.tweet = tweet
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath( indexPath, animated: false)
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "viewMentionTweetDetail" {
            let cell = sender as!  UITableViewCell
            let indexPath = tableView.indexPathForCell(cell)!
            let tweet = tweets?[indexPath.row]
            let tweetDetailViewController = segue.destinationViewController as! TweetDetailViewController
            tweetDetailViewController.tweet = tweet
        } else if segue.identifier == "composeTweet" {
            let dvc = segue.destinationViewController as! UINavigationController
            _ = dvc.topViewController as! ComposeViewController
            
        }
    }

}
