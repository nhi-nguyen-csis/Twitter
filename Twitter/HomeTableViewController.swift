//
//  HomeTableViewController.swift
//  Twitter
//
//  Created by Nhi Nguyen on 3/11/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
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
    }
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

 

}
