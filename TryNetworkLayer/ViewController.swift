//
//  ViewController.swift
//  TryNetworkLayer
//
//  Created by Andrea on 21/08/2017.
//  Copyright © 2017 Ennova Research Srl. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let usersRepo = UsersRepo()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usersRepo.fetch { (users) in
            for user in users {
                print("\(String(describing: user.login))")
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
