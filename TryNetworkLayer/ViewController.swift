//
//  ViewController.swift
//  TryNetworkLayer
//
//  Created by Andrea on 21/08/2017.
//  Copyright © 2017 Ennova Research Srl. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let dispatcher = NetworkDispatcher(environment: Environment("Github", host: "https://api.github.com"))
    let usersTask = UsersTask()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usersTask.execute(in: dispatcher) { (users, error) in
            
            if let users = users {
                for user in users {
                    print("\(String(describing: user.login))")
                }
            } else if let error = error {
                print("\(String(describing: error.localizedDescription))")
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

