//
//  profileViewController.swift
//  TwitterDemo
//
//  Created by Bconsatnt on 3/6/17.
//  Copyright © 2017 Bconsatnt. All rights reserved.
//

import UIKit

class profileViewController: UIViewController {

    @IBOutlet weak var avatarImage: UIImageView!
    
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var followerLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    var user: User! /*{
        didSet {
            self.avatarImage.setImageWith(User.currentUser!.profileUrl!)
            self.nameLabel.text = User.currentUser!.name!
            self.nameLabel.sizeToFit()
            self.usernameLabel.text = User.currentUser!.screenname!
            self.usernameLabel.sizeToFit()
            self.tweetLabel.text = "\(User.currentUser!.tweetCount!)"
            self.followerLabel.text = "\(User.currentUser!.followerCount!)"
            self.followingLabel.text = "\(User.currentUser!.followingCount!)"
        }
    }*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.user = User.currentUser!
        self.avatarImage.setImageWith(user.profileUrl!)
        self.nameLabel.text = user.name!
        self.nameLabel.sizeToFit()
        self.usernameLabel.text = user.screenname!
        self.usernameLabel.sizeToFit()
        self.tweetLabel.text = "\(user.tweetCount!)"
        self.tweetLabel.sizeToFit()
        self.followerLabel.text = "\(user.followerCount!)"
        self.followerLabel.sizeToFit()
        self.followingLabel.text = "\(user.followingCount!)"
        self.followingLabel.sizeToFit()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
