//
//  HomeTableViewController.swift
//  Twitter
//
//  Created by Nhi Nguyen on 3/11/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {
    
    //create an empty array of dictionary
    var tweetArray =  [NSDictionary]()
    var numberOfTweet: Int!
    
    // add refresh control
    let myRefreshControll = UIRefreshControl()
    
    // viewDidLoad() only called once when the program first starts
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //target: where you want this happen: self = this screen
        //action: what do you want Apple to do?
        myRefreshControll.addTarget(self, action: #selector(loadTweets), for: .valueChanged)
        tableView.refreshControl = myRefreshControll
        tableView.rowHeight = UITableView.automaticDimension
        // even tableview we set to automatically dimension, but we can
        // set it to start with at least a certain height, 150 in this case
        tableView.estimatedRowHeight = 150
        
    }
    
    // viewDidAppear get call multiple times whenever a view appears on the screen
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //after the screen is done loading, call the loadTweet() to request API
        loadTweets()
    }
    
    // func to call API
    @objc func loadTweets(){
        
        numberOfTweet = 20
        let url = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        // myParams to pass to the API to get exactly how many tweets you want
        // count is the API's parameter
        let myParams = ["count": numberOfTweet]
        
        // call the API to get multiple tweets --> need to use getDictionariesRequest, instead of getDictionaryRequest (1 tweet only)
        TwitterAPICaller.client?.getDictionariesRequest(url: url, parameters: myParams, success:
        { (tweets: [NSDictionary]) in
            
            self.tweetArray.removeAll()
            for tweet in tweets {
                self.tweetArray.append(tweet)
            }
            
            // everytime we call API, we repopulate our list to reload the data with the new content
            self.tableView.reloadData()
            
            // stop the refreshing
            self.myRefreshControll.endRefreshing()
            
        }, failure: { Error in
            print("Could not retrieve tweets! oh no!")
        })
        
    }
    
    
    func loadMoreTweets(){
        
        let myUrl = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        numberOfTweet = numberOfTweet + 20
        let myParams = ["count": numberOfTweet]
        
        // call the API to get multiple tweets --> need to use getDictionariesRequest, instead of getDictionaryRequest (1 tweet only)
        TwitterAPICaller.client?.getDictionariesRequest(url: myUrl, parameters: myParams as [String : Any], success:
        { (tweets: [NSDictionary]) in
            
            self.tweetArray.removeAll()
            for tweet in tweets {
                self.tweetArray.append(tweet)
            }
            
            // everytime we call API, we repopulate our list to reload the data with the new content
            self.tableView.reloadData()
            
        }, failure: { Error in
            print("Could not retrieve tweets! oh no!")
        })
        
    }
    
    
    // when user scroll down and gets to the end of the table call the loadMoreTweets()
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == tweetArray.count {
            loadMoreTweets()
        }
    }
    

    // this func is executed when users click on logout button
    @IBAction func onLogout(_ sender: UIBarButtonItem) {
        // logout the user
        TwitterAPICaller.client?.logout()
        //after user log out, transition user back to login screen
        //self.dismiss means the screen gonna dismiss itself or disappear
        //completion: do you want to do anything when the screen is gone
        // no, we don't want anything happen
        self.dismiss(animated: true, completion: nil)
        // false means the user log out, not log in
        UserDefaults.standard.set(false, forKey: "userLoggedIn")
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // withIdentifier: name of the prototype cell
        // cast it as TweetCellTableViewCell
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell",
                                                 for: indexPath) as! TweetCellTableViewCell
        
        //extract user name from API call
        //casting it to dictionary
        let user = tweetArray[indexPath.row]["user"] as! NSDictionary
        cell.userNameLabel.text = user["name"] as? String
        cell.tweetContent.text = tweetArray[indexPath.row]["text"] as? String
        
        
        //extract user's profile image from API
        let imageUrl = URL(string: (user["profile_image_url_https"] as? String)!)
        let data = try? Data(contentsOf: imageUrl!)
        
        if let imageData = data {
            cell.profileImageView.image = UIImage(data: imageData)
        }
        
        //check if the current tweet is favorite or not
        cell.setFavorite(tweetArray[indexPath.row]["favorited"] as! Bool)
        cell.tweetId = tweetArray[indexPath.row]["id"] as! Int
        cell.setRetweeted(tweetArray[indexPath.row]["retweeted"] as! Bool)
        
        return cell
    }
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1 // our table has only 1 section
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tweetArray.count
    }

 

}
