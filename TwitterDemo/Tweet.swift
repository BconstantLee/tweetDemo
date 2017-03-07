//
//  Tweet.swift
//  TwitterDemo
//
//  Created by Bconsatnt on 2/27/17.
//  Copyright © 2017 Bconsatnt. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var text: String?
    var timestamp: Date?
    var retweetCount: Int = 0
    var favoriteCount: Int = 0
    var screeName: String?
    var name: String?
    var profileImageUrl: URL?
    var retweeted: Bool? = false
    var favorited: Bool? = false
    var id: Int?
    var followed: Bool? = false
    var user: User!
    
    init(dictionary: NSDictionary) {
        text = dictionary["text"] as? String
//        print("text:\(text)\n")
        id = (dictionary["id"] as? Int) ?? 0
        
        retweeted = dictionary["retweeted"] as? Bool
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favorited = dictionary["favorited"] as? Bool
        favoriteCount = (dictionary["favorite_count"] as? Int) ?? 0
//        followed = dictionary["following"] as? Bool
//        print("fcount: \(dictionary["favorite_count"])")
//        print("fol: \(followed)")
        
        let timestampString = dictionary["created_at"] as? String
        if let timestampString = timestampString {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timestamp = formatter.date(from: timestampString)
        }
        
        let userDic: NSDictionary = (dictionary["user"] as? NSDictionary) ?? [:]
        user = User(dictionary: userDic)
        if userDic.count > 0 {
            if let profileImageUrlString = userDic["profile_image_url_https"] as? String {
                profileImageUrl = URL(string: profileImageUrlString)
            }
//            print("user:\(user["statuses_count"])")
//            print("user:\(user["friends_count"])")
//            print("user:\(user["followers_count"])")
//            screeName = userDic["screen_name"] as? String
            screeName = user.screenname!
//            name = userDic["name"] as? String
            name = user.name!
        }
    }
    
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in dictionaries {
//            print("bcount: \(dictionary["favorite_count"])")
            let tweet = Tweet(dictionary: dictionary)
            tweets.append(tweet)
        }
        
        return tweets
    }
}
