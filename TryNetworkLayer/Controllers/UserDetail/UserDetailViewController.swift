//
//  UserDetailViewController.swift
//  TryNetworkLayer
//
//  Created by Andrea Stevanato on 03/09/2017.
//  Copyright © 2019 Andrea Stevanato All rights reserved.
//

import Combine
import UIKit

final  class UserDetailViewController: UIViewController {

    @IBOutlet weak private var usernameLabel: UILabel!
    
    var viewModel: UserDetailViewModel!
    private var bindings = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupObservers()
        self.viewModel.fecthUser()
    }
    
    func setupObservers() {
        let usernameHandler: (String) -> Void = { [weak self] username in
            self?.usernameLabel.text = username
        }

        viewModel.$username
            .receive(on: RunLoop.main)
            .sink(receiveValue: usernameHandler)
            .store(in: &bindings)

        // not working
        // viewModel.$username.assign(to: \.text, on: usernameLabel)
    }
}
