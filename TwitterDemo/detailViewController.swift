//
//  detailViewController.swift
//  TwitterDemo
//
//  Created by Bconsatnt on 3/6/17.
//  Copyright © 2017 Bconsatnt. All rights reserved.
//

import UIKit

class detailViewController: UIViewController {

    @IBOutlet weak var favoButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var followButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    
    var id: Int?
    var isFavorited = false
    var isRetweeted = false
    var retweetCount: Int! = 0
    var favoriteCount: Int! = 0
    var isFollowed = false
    var tweet: Tweet!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = "\(tweet.name!)"
        nameLabel.sizeToFit()
        usernameLabel.text = "\(tweet.screeName!)"
        usernameLabel.sizeToFit()
        textLabel.text = "\(tweet.text!)"
        textLabel.sizeToFit()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm y"
        let dateString = formatter.string(from:tweet.timestamp!)
        timeLabel.text = "\(dateString)"
        timeLabel.sizeToFit()
        
        avatarImage.setImageWith(tweet.profileImageUrl!)
        isFavorited = tweet.favorited!
        isRetweeted = tweet.retweeted!
//        isFollowed = tweet.followed!
        id = tweet.id!
        retweetCount = tweet.retweetCount
        favoriteCount = tweet.favoriteCount
//        if (isFollowed) {
//            followButton.setTitle("Following", for: .normal)
//            followButton.backgroundColor = UIColor.blue
//        } else {
//            followButton.setTitle("Unfollow", for: .normal)
//            followButton.backgroundColor = UIColor.red
//        }
        
        if (isRetweeted) {
            retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: .normal)
        } else {
            retweetButton.setImage(UIImage(named: "retweet-icon"), for: .normal)
        }
        retweetButton.setTitle("\(retweetCount!)", for: .normal)
        retweetButton.titleLabel?.sizeToFit()
        
        if (isFavorited) {
            favoButton.setImage(UIImage(named: "favor-icon"), for: .normal)
        } else {
            favoButton.setImage(UIImage(named: "favor-icon-red"), for: .normal)
        }
        favoButton.setTitle("\(favoriteCount!)", for: .normal)
        favoButton.titleLabel?.sizeToFit()
        // Do any additional setup after loading the view.
    }
    
    func retweet() {
        isRetweeted = true
        retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: .normal)
        retweetCount = retweetCount + 1
        retweetButton.setTitle("\(retweetCount!)", for: .normal)
    }
    
    func unretweet() {
        isRetweeted = false
        retweetButton.setImage(UIImage(named: "retweet-icon"), for: .normal)
        retweetCount = retweetCount - 1
        retweetButton.setTitle("\(retweetCount!)", for: .normal)
    }
    
    func favorite() {
        isFavorited = true
        favoButton.setImage(UIImage(named: "favor-icon-red"), for: .normal)
        favoriteCount = favoriteCount + 1
        favoButton.setTitle("\(favoriteCount!)", for: .normal)
    }
    
    func unfavorite() {
        isFavorited = false
        favoButton.setImage(UIImage(named: "favor-icon"), for: .normal)
        favoriteCount = favoriteCount - 1
        favoButton.setTitle("\(favoriteCount!)", for: .normal)
    }
    
    func follow() {
        isFollowed = true
        followButton.setTitle("Following", for: .normal)
        followButton.backgroundColor = UIColor.blue
    }
    func unfollow() {
        isFollowed = false
        followButton.setTitle("Unfollow", for: .normal)
        followButton.backgroundColor = UIColor.red
    }
    
    @IBAction func onReply(_ sender: AnyObject) {
    }

    @IBAction func onFollow(_ sender: AnyObject) {
    }
    
    @IBAction func onFavorite(_ sender: AnyObject) {
        if let id = id {
            if isFavorited {
                TwitterClient.sharedInstance?.unfavorite(id: id, success: { (NSDictionary) in
                    self.unfavorite()
                    }, failure: { (error: Error) in
                        print("Error: \(error.localizedDescription)")
                })
            } else {
                TwitterClient.sharedInstance?.favorite(id: id, success: { (NSDictionary) in
                    self.favorite()
                    }, failure: { (error: Error) in
                        print("Error: \(error.localizedDescription)")
                })
            }
        }
    }
    
    @IBAction func onRetweet(_ sender: AnyObject) {
        if let id = id {
            if isRetweeted {
                TwitterClient.sharedInstance?.unretweet(id: id, success: { (NSDictionary) in
                    self.unretweet()
                    }, failure: { (error: Error) in
                        print("Error: \(error.localizedDescription)")
                })
                
            } else {
                TwitterClient.sharedInstance?.retweet(id: id, success: { (NSDictionary) in
                    self.retweet()
                    }, failure: { (error: Error) in
                        print("Error: \(error.localizedDescription)")
                })
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "replySegue" {
            let destination = segue.destination as! composeViewController
            destination.replyTo = "@\(tweet.screeName!)"
        }
    }
    

}
