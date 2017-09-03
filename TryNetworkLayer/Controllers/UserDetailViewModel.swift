//
//  UserDetailViewModel.swift
//  TryNetworkLayer
//
//  Created by Andrea Stevanato on 03/09/2017.
//  Copyright © 2017 Ennova Research Srl. All rights reserved.
//

import Foundation
import Bond

class UserDetailViewModel {
    
    // MARK: Observables
    
    let username = Observable<String>("")
    
    // MARK: Properties
    
    let usersRepo = UsersRepo()
    fileprivate var user: GHUserDetail?
    
    // MARK: Methods
    
    func fecthUser(login: String) {
        usersRepo.fetchDetail(username: login) { [unowned self] (user) in
            if let user = user {
                self.username.value = user.login!
            }
        }
    }
}
