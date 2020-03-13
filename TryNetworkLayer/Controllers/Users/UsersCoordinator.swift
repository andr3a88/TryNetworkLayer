//
//  UsersCoordinator.swift
//  TryNetworkLayer
//
//  Created by Andrea Stevanato on 13/03/2020.
//  Copyright © 2020 Andrea Stevanato. All rights reserved.
//

import UIKit

final class UsersCoordinator: Coordinator {

    var window: UIWindow
    var navigationController: UINavigationController!

    var userDetailCoordinator: UserDetailCoordinator?

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        let usersViewController = Storyboard.main.instantiate(UsersViewController.self)
        usersViewController.viewModel = UsersViewModel()
        usersViewController.viewModel.coordinatorDelegate = self
        
        self.navigationController = UINavigationController(rootViewController: usersViewController)
        self.window.rootViewController = navigationController
    }
}

extension UsersCoordinator: UsersViewModelCoordinatorDelegate {
    func usersViewModelPresent(user: GHUser) {
        userDetailCoordinator = UserDetailCoordinator(navigationController: navigationController, user: user)
        userDetailCoordinator?.start()
    }
}
