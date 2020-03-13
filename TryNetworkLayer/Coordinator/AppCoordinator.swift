//
//  AppCoordinator.swift
//  TryNetworkLayer
//
//  Created by Andrea Stevanato on 13/03/2020.
//  Copyright © 2020 Andrea Stevanato. All rights reserved.
//

import UIKit

protocol Coordinator {
    func start()
}

/// A coordinator based on a navigation controller
protocol NavigationCoordinator: Coordinator {
    var navigationController: UINavigationController { get }
}

private enum ChildCoordinator {
    case root
}

final class AppCoordinator: Coordinator {

    // MARK: - Properties

    private unowned var sceneDelegate: SceneDelegate
    private weak var window: UIWindow!

    // Keep reference of the current coordinators
    private var coordinators = [ChildCoordinator: Coordinator]()

    // MARK: - Initializer

    init(sceneDelegate: SceneDelegate) {
        self.sceneDelegate = sceneDelegate
        self.window = sceneDelegate.window!
    }

    // MARK: - Coordinator

    func start() {
        let usersCoordinator = UsersCoordinator(window: window)
        usersCoordinator.start()
        self.coordinators[.root] = usersCoordinator
    }
}
