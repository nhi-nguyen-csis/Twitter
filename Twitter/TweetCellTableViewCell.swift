//
//  TweetCellTableViewCell.swift
//  Twitter
//
//  Created by Nhi Nguyen on 3/11/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit

class TweetCellTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tweetContent: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favButton: UIButton!
    
    var favorited:Bool = false
    // initialized it to -1, meaning it's not set
    var tweetId:Int = -1
    
    @IBAction func favoriteTweet(_ sender: Any) {
        let toBeFavorited = !favorited
        if (toBeFavorited){
            // call API
            TwitterAPICaller.client?.favoriteTwwet(tweetId: tweetId,
                                                   success: {
                // change the color of the button
                self.setFavorite(true)
            }, failure: { error in
                print("Favorite did not succeed: \(error)")
            })
        }else{
            TwitterAPICaller.client?.unfavoriteTwwet(tweetId: tweetId,
                                                   success: {
                self.setFavorite(false)
            }, failure: { error in
                print("Unfavorite did not succeed: \(error)")
            })
        }
    }
    
    
    
    @IBAction func retweet(_ sender: Any) {
    }
    
    
    func setFavorite(_ isFavorited:Bool){
        favorited = isFavorited
        if (favorited){
            favButton.setImage(UIImage(named: "favor-icon-red"),
                               for: UIControl.State.normal)
        } else{
            favButton.setImage(UIImage(named: "favor-icon"),
                               for: UIControl.State.normal)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
