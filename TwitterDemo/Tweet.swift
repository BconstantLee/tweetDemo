//
//  Tweet.swift
//  TwitterDemo
//
//  Created by Bconsatnt on 2/27/17.
//  Copyright © 2017 Bconsatnt. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var text: NSString?
    var timestamp: Date?
    var retweetCount: Int = 0
    var favoriteCount: Int = 0
    var screeName: String?
    var name: String?
    var profileImageUrl: URL?
    var retweeted: Bool? = false
    var favorited: Bool? = false
    var id: Int?
    
    init(dictionary: NSDictionary) {
        text = dictionary["text"] as? NSString
        id = (dictionary["id"] as? Int) ?? 0
        
        retweeted = dictionary["retweeted"] as? Bool
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favorited = dictionary["favorited"] as? Bool
        favoriteCount = (dictionary["favourites_count"] as? Int) ?? 0
        
        let timestampString = dictionary["created_at"] as? String
        if let timestampString = timestampString {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timestamp = formatter.date(from: timestampString)
        }
        
        let user: NSDictionary = (dictionary["user"] as? NSDictionary) ?? [:]
        if user.count > 0 {
            if let profileImageUrlString = user["profile_image_url_https"] as? String {
                profileImageUrl = URL(string: profileImageUrlString)
            }
            
            screeName = user["screen_name"] as? String
            
            name = user["name"] as? String
        }
    }
    
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in dictionaries {
            let tweet = Tweet(dictionary: dictionary)
            tweets.append(tweet)
        }
        
        return tweets
    }
}
