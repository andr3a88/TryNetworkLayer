//
//  UserDetailViewModel.swift
//  TryNetworkLayer
//
//  Created by Andrea Stevanato on 03/09/2017.
//  Copyright © 2019 Andrea Stevanato All rights reserved.
//

import Foundation
import Bond

class UserDetailViewModel {
    
    // MARK: Observables
    
    let username = Observable<String>("")
    
    // MARK: Properties
    
    let usersRepo = UsersRepo()
    var user: GHUserDetail?
    
    // MARK: Methods

    init(userLogin: String) {
        self.fecthUser(userLogin: userLogin)
    }
    
    func fecthUser(userLogin: String) {
        usersRepo.fetchDetail(username: userLogin) { [unowned self] (user) in
            if let user = user {
                self.user = user
                self.username.value = user.login!
            }
        }
    }
}
