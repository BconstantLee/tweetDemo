//
//  tweetCell.swift
//  TwitterDemo
//
//  Created by Bconsatnt on 2/27/17.
//  Copyright © 2017 Bconsatnt. All rights reserved.
//

import UIKit

class tweetCell: UITableViewCell {

    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var textField: UILabel!
    @IBOutlet weak var imageCell: UIImageView!
    
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var retweetLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var favoriteLabel: UILabel!
    
    var id: Int?
    var isFavorited = false
    var isRetweeted = false
    var retweetCount: Int! = 0
    var favoriteCount: Int! = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func retweet() {
        isRetweeted = true
        retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: .normal)
        retweetCount = retweetCount + 1
        retweetLabel.text = "\(retweetCount!)"
    }
    
    func unretweet() {
        isRetweeted = false
        retweetButton.setImage(UIImage(named: "retweet-icon"), for: .normal)
        retweetCount = retweetCount - 1
        retweetLabel.text = "\(retweetCount!)"
    }
    
    func favorite() {
        isFavorited = true
        favoriteButton.setImage(UIImage(named: "favor-icon"), for: .normal)
        favoriteCount = favoriteCount + 1
        favoriteLabel.text = "\(favoriteCount!)"
    }
    
    func unfavorite() {
        isFavorited = false
        favoriteButton.setImage(UIImage(named: "favor-icon-1"), for: .normal)
        favoriteCount = favoriteCount - 1
        favoriteLabel.text = "\(favoriteCount!)"
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
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
