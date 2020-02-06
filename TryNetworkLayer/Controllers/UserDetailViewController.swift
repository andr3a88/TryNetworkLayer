//
//  UserDetailViewController.swift
//  TryNetworkLayer
//
//  Created by Andrea Stevanato on 03/09/2017.
//  Copyright © 2019 Andrea Stevanato All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController {

    @IBOutlet weak var usernameLabel: UILabel!
    
    var viewModel: UserDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupObservers()
    }
    
    func setupObservers() {
        _ = viewModel.username.observeNext(with: { [unowned self] (username) in
            self.usernameLabel.text = username
        })
    }
}
