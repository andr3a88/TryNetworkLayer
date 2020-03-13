//
//  UserDetailViewModel.swift
//  TryNetworkLayer
//
//  Created by Andrea Stevanato on 03/09/2017.
//  Copyright © 2019 Andrea Stevanato All rights reserved.
//

import Foundation

final class UserDetailViewModel {
    
    // MARK: Observables

    @Published var username: String = ""
    
    // MARK: Properties

    private(set) var user: GHUserDetail?
    let usersRepo: UsersRepoProtocol

    // MARK: Methods

    init(usersRepo: UsersRepoProtocol = UsersRepo(), userLogin: String) {
        self.usersRepo = usersRepo
        self.username = userLogin
    }

    func fecthUser() {
        usersRepo.fetchDetail(username: username) { [weak self] (user) in
            if let user = user {
                self?.user = user
                self?.username = user.login!
            }
        }
    }
}
