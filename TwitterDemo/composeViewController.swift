//
//  composeViewController.swift
//  TwitterDemo
//
//  Created by Bconsatnt on 3/6/17.
//  Copyright © 2017 Bconsatnt. All rights reserved.
//

import UIKit

class composeViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var avatarImage: UIImageView!
    
    @IBOutlet weak var textField: UITextField!
    var replyTo: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        textField.text = replyTo
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onCancel(_ sender: AnyObject) {
        self.replyTo = ""
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onSubmit(_ sender: AnyObject) {
        self.replyTo = ""
        dismiss(animated: true, completion: nil)
    }
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
//                   replacementString string: String) -> Bool
//    {
//        let maxLength = 128
//        let currentString: String = textField.text!
//        let newString: String = currentString.stringByReplacingCharactersInRange(range, withString: string)
//        return newString.length <= maxLength
//    }

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
