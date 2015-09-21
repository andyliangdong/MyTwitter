//
//  MenuViewController.swift
//  TwitterApp
//
//  Created by Andy (Liang) Dong on 9/20/15.
//  Copyright © 2015 codepath. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    private var tweetsViewController: UIViewController?
    private var profileViewController: UIViewController?
    private var mentionsViewController: UIViewController?
    
    var viewControllers: [UIViewController] = []
    
    weak var hamburgerViewController : HamburgerViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        tweetsViewController = storyboard.instantiateViewControllerWithIdentifier("TweetsNavController")
        profileViewController = storyboard.instantiateViewControllerWithIdentifier("ProfileViewController")
        mentionsViewController = storyboard.instantiateViewControllerWithIdentifier("MentionsViewController")
        
        viewControllers.append(tweetsViewController!)
        viewControllers.append(profileViewController!)
        viewControllers.append(mentionsViewController!)
        
        hamburgerViewController.contentViewController = tweetsViewController!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewControllers.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MenuCell", forIndexPath: indexPath) as! MenuCell
        let titles = ["Home Timeline", "Profile", "Mentions"]
        cell.menuTitleLabel.text = titles[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        hamburgerViewController.contentViewController = viewControllers[indexPath.row]
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
