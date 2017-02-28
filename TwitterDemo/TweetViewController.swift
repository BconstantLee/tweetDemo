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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.estimatedRowHeight = 180
        tableView.rowHeight = UITableViewAutomaticDimension
        
        TwitterClient.sharedInstance!.homeTimeLine(success: { (tweets: [Tweet]) in
            self.tweets = tweets
            self.tableView.reloadData()
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
        if tweets != nil {
            return tweets.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! tweetCell
        
        let tweet = tweets[indexPath.row]
        
        cell.nameLabel.text = tweet.name as String?
        cell.nameLabel.sizeToFit()
        cell.id = tweet.id
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
            
            cell.favoriteButton.setImage(UIImage(named: "favor-icon"), for: .normal)
        } else { cell.favoriteButton.setImage(UIImage(named: "favor-icon-1"), for: .normal) }
        
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
    
    @IBAction func onLogout(_ sender: AnyObject) {
        TwitterClient.sharedInstance!.logout()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
