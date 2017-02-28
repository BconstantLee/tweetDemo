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
        
        cell.textField.text = tweet.text as String?
        cell.textField.sizeToFit()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE MMM d y"
        let dateString = formatter.string(from:tweet.timestamp!)
        cell.timeLabel.text = dateString
        cell.timeLabel.sizeToFit()
        
        if let profileUrl = tweet.profileImageUrl {
            print("enter:\(profileUrl)")
            cell.imageCell.setImageWith(profileUrl)
        } else { cell.imageCell = nil }
        
        return cell
        
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
