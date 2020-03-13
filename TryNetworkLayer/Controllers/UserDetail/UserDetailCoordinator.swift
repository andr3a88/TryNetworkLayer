//
//  UserDetailCoordinator.swift
//  TryNetworkLayer
//
//  Created by Andrea Stevanato on 13/03/2020.
//  Copyright © 2020 Andrea Stevanato. All rights reserved.
//

import UIKit

final class UserDetailCoordinator: NavigationCoordinator {

    let navigationController: UINavigationController
    private let user: GHUser

    init(navigationController: UINavigationController, user: GHUser) {
        self.navigationController = navigationController
        self.user = user
    }

    func start() {
        let userDetailViewController = Storyboard.main.instantiate(UserDetailViewController.self)
        userDetailViewController.viewModel = UserDetailViewModel(userLogin: self.user.login)
        self.navigationController.pushViewController(userDetailViewController, animated: true)
    }
}
