//
//  TwitterClient.swift
//  TwitterDemo
//
//  Created by Bconsatnt on 2/27/17.
//  Copyright © 2017 Bconsatnt. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {
    static let sharedInstance = TwitterClient(baseURL: NSURL(string: "https://api.twitter.com") as URL!, consumerKey: "EDTSBLcEsONZv7blCI6fXIXHx", consumerSecret: "uEZohsB0ZLeQ8Gu2oj3rc3lQqD3hb4CKBJIZtFH3MprX8iSghn")
    
    var loginSuccess: (() -> ())?
    var loginFailure: ((Error) -> ())?
    
    func homeTimeLine(success: @escaping ([Tweet]) -> (), failure: @escaping (Error) -> ()) {
        get("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            let dictionaries = response as! [NSDictionary]
            let tweets = Tweet.tweetsWithArray(dictionaries: dictionaries)
            
            success(tweets)
        }, failure: { (task: URLSessionDataTask?, error: Error) in
                failure(error)
        })
    }
    
    func currentAccount(success: @escaping (User) -> (), failure: @escaping (Error) -> ()) {
        get("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            if let response = response {
                let userDictionary = response as! NSDictionary
            //                    print("\(userDictionary)")
                let user = User(dictionary: userDictionary)
                success(user)
            }
        }, failure: { (task: URLSessionDataTask?, error: Error) in
                failure(error)
        })
        
    }
    
    func login(success: @escaping () -> (), failure: @escaping (Error) -> ()) {
        loginSuccess = success
        loginFailure = failure
        
        deauthorize()
        fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: NSURL(string: "twitterdemo://oauth") as URL!, scope: nil, success: { (requestToken: BDBOAuth1Credential?) in
            let token = requestToken!.token!
            let url = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(token)")!
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
            
        }) { (error: Error?) in
            self.loginFailure?(error!)
//            print("Error: \(error!.localizedDescription)")
        }
    }
    
    func logout() {
        deauthorize()
        User.currentUser = nil
        
        NotificationCenter.default.post(name: User.userDidLogoutNotification, object: nil)
    }
    
    func handleOpenUrl(url: URL) {
        let requestToken = BDBOAuth1Credential(queryString: url.query)!
        
        fetchAccessToken(withPath: "oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken: BDBOAuth1Credential?) in
            
            self.currentAccount(success: { (user: User) in
                User.currentUser = user
                self.loginSuccess?()
            }, failure: { (error: Error) in
                    self.loginFailure?(error)
            })
            
            self.loginSuccess?()
            
        }) { (error: Error?) in
            self.loginFailure?(error!)
        }
    }
}
