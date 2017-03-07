//
//  TweetViewController.swift
//  TwitterDemo
//
//  Created by Bconsatnt on 2/27/17.
//  Copyright © 2017 Bconsatnt. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var tweets: [Tweet]!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var profileView: UITableView!
    var selectedUser: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        profileView.dataSource = self
        profileView.delegate = self
        
        tableView.estimatedRowHeight = 180
        tableView.rowHeight = UITableViewAutomaticDimension
        
        TwitterClient.sharedInstance!.homeTimeLine(success: { (tweets: [Tweet]) in
            self.tweets = tweets
            self.tableView.reloadData()
            self.profileView.reloadData()
            self.selectedUser = User.currentUser!
//            self.usernameLabel.text = User.currentUser!.name
//            self.usernameLabel.sizeToFit()
//            self.avatarImage.setImageWith(User.currentUser!.profileUrl!)
//            for tweet in tweets {
//                print("count")
//                print("\(tweet.name!)")
//            }
        }, failure: { (error: Error) in
            print("Error: \(error.localizedDescription)")
        })
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.tableView {
            if tweets != nil {
                return tweets.count
            }
        }
        else if tableView == self.profileView {
            if User.currentUser != nil {
                return 1
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell2 = UITableViewCell()

        if tableView == self.tableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! tweetCell
            let tweet = tweets[indexPath.row]

            cell.nameLabel.text = tweet.name as String?
            cell.nameLabel.sizeToFit()
            
            cell.id = tweet.id
            cell.user = tweet.user
            cell.rootView = self
//            print("cell:\(cell.user.name)")
            
            cell.favoriteCount = tweet.favoriteCount
            cell.favoriteLabel.text = ("\(tweet.favoriteCount)")
            cell.retweetCount = tweet.retweetCount
            cell.retweetLabel.text = ("\(tweet.retweetCount)")
            cell.isRetweeted = tweet.retweeted!
            if tweet.retweeted! {
                cell.retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: .normal)
            } else { cell.retweetButton.setImage(UIImage(named: "retweet-icon"), for: .normal) }
            cell.isFavorited = tweet.favorited!
            if tweet.favorited! {
            
                cell.favoriteButton.setImage(UIImage(named: "favor-icon-red"), for: .normal)
            } else { cell.favoriteButton.setImage(UIImage(named: "favor-icon"), for: .normal) }
        
            cell.textField.text = tweet.text as String?
            cell.textField.sizeToFit()
        
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm y"
            let dateString = formatter.string(from:tweet.timestamp!)
            cell.timeLabel.text = dateString
            cell.timeLabel.sizeToFit()
        
            if let profileUrl = tweet.profileImageUrl {
                cell.imageCell.setImageWith(profileUrl)
            } else { cell.imageCell = nil }
            return cell
       }
       else if tableView == self.profileView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "profileCell", for: indexPath) as! profileCell
            cell.avatarImage.setImageWith(User.currentUser!.profileUrl!)
            cell.nameLabel.text = User.currentUser!.name!
            cell.nameLabel.sizeToFit()
            return cell
        }
        return cell2
    }
    
    
    @IBAction func onLogout(_ sender: AnyObject) {
        TwitterClient.sharedInstance!.logout()
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "detailSegue" {
//            let cell = sender as! UITableViewCell
//            let indexPath = tableView.indexPath(for: cell)
//            tableView.deselectRow(at: indexPath!, animated: true)
            let destination = segue.destination as! detailViewController
            let row = tableView.indexPathForSelectedRow?.row
//            print("row:\(row!)")
//            print("tweet:\(tweets[row!].name!)")
            let tweet = tweets[row!]
            destination.tweet = tweet
        } else if segue.identifier == "selfSegue" {
//            let cell = sender as! UITableViewCell
//            let indexPath = profileView.indexPath(for: cell)
//            profileView.deselectRow(at: indexPath!, animated: false)
            let destination = segue.destination as! profileViewController
            let user = self.selectedUser
//            let user = User.currentUser!
            destination.user = user
        } else if segue.identifier == "composeSegue" {
            let navController = segue.destination as! UINavigationController
            let destination = navController.topViewController as! composeViewController
            destination.replyTo = ""
        }
    }
    

}
