Time spent: <15>

Features
Required

[Y] Hamburger menu
[Y] Dragging anywhere in the view should reveal the menu.
[Y] The menu should include links to your profile, the home timeline, and the mentions view.
[Y] The menu can look similar to the LinkedIn menu below or feel free to take liberty with the UI.
[Y] Profile page
[Y] Contains the user header view
[Y] Contains a section with the users basic stats: # tweets, # following, # followers
[Y] Home Timeline
[ ] Tapping on a user image should bring up that user's profile page
Not done the tweets in the Profile page yet.
Will add Gif tmr
Optional

[ ] Profile Page
[ ] Optional: Implement the paging view for the user description.
[ ] Optional: As the paging view moves, increase the opacity of the background screen. See the actual Twitter app for this effect
[ ] Optional: Pulling down the profile page should blur and resize the header image.
[ ] Optional: Account switching
[ ] Long press on tab bar to bring up Account view with animation
[ ] Tap account to switch to
[ ] Include a plus button to Add an Account
[ ] Swipe to delete an account











# MyTwitterApp

This is a basic twitter app to read and compose tweets the Twitter API.

Time spent: <Number of hours spent>

Features
Required

[2] User can sign in using OAuth login flow
[2] User can view last 20 tweets from their home timeline
[2] The current signed in user will be persisted across restarts
[4] In the home timeline, user can view tweet with the user profile picture, username, tweet text, and timestamp. In other words, design the custom cell with the proper Auto Layout settings. You will also need to augment the model classes.
[ ] User can pull to refresh
[ ] User can compose a new tweet by tapping on a compose button.
[2] User can tap on a tweet to view it, with controls to retweet, favorite, and reply.
[ ] User can retweet, favorite, and reply to the tweet directly from the timeline feed.
Optional

[ ] When composing, you should have a countdown in the upper right for the tweet limit.
[ ] After creating a new tweet, a user should be able to view it in the timeline immediately without refetching the timeline from the network.
[ ] Retweeting and favoriting should increment the retweet and favorite count.
[ ] User should be able to unretweet and unfavorite and should decrement the retweet and favorite count.
[ ] Replies should be prefixed with the username and the reply_id should be set when posting the tweet,
[ ] User can load more tweets once they reach the bottom of the feed using infinite loading similar to the actual Twitter client.


[Problem Solved By Segue from the upper yellow square]
after adding the Navigation Controller that there is some bug that
the sign in cannot see the correct user profile.
I spend a lot of time and find the warning occurs at
self.performSegueWithIdentifier("loginSegue", sender: self) in ViewController.swift
2015-09-15 23:26:39.130 TwitterApp[15133:721522] Warning: Attempt to present <UINavigationController: 0x7ffe195be500> on <TwitterApp.ViewController: 0x7ffe1b812ad0> whose view is not in the window hierarchy!



![Walkthrough](twitterApp_v1.gif)

