//
//  TweetViewController.swift
//  Twitter
//
//  Created by Nhi Nguyen on 3/17/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController {
    @IBOutlet weak var tweetTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // display the keyboard
        tweetTextView.becomeFirstResponder()

    }
    
    @IBAction func cancel(_ sender: Any) {
        //user pressed cancel, we will dismiss the controller
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tweet(_ sender: Any) {
        if (!tweetTextView.text.isEmpty){
            TwitterAPICaller.client?.postTweet(tweetString: tweetTextView.text,
                                               success: {
                self.dismiss(animated: true, completion: nil)
            }, failure: { error in
                print("Error posting tweet \(error)")
                self.dismiss(animated: true, completion: nil)
            })
        }else{ // if the text is empty
            self.dismiss(animated: true, completion: nil)
        }
    }
}
