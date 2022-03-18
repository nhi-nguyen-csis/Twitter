//
//  LoginViewController.swift
//  Twitter
//
//  Created by Nhi Nguyen on 3/10/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // when the page shows up, what do you want Apple to do?
    override func viewDidAppear(_ animated: Bool) {
        //check the userDefaults
        if UserDefaults.standard.bool(forKey: "userLoggedIn") == true {
            //don't ask user log in again, run the segue immediately
            self.performSegue(withIdentifier: "loginToHome", sender: self)
        }
    }
    

    
    @IBAction func onLoginButton(_ sender: Any) {
        let myUrl: String = "https://api.twitter.com/oauth/request_token"
        TwitterAPICaller.client?.login(url: myUrl, success: {
            //trigger the connection when login success
            //1 . allow user to stay login
            //value = true --> when user login, value = true
            //forKey = the name of the value
            UserDefaults.standard.set(true, forKey: "userLoggedIn")
            
            // 2. transition user from login view to home view
            // perform segue
            // segue is a transition
            // withIdentifier is the name of our transition
            self.performSegue(withIdentifier: "loginToHome", sender: self)
        }, failure: { (Error) in
            print("Could not log in!")
        })
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
