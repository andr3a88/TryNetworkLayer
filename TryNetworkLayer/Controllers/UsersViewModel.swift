//
//  UsersViewModel.swift
//  TryNetworkLayer
//
//  Created by Andrea Stevanato on 03/09/2017.
//  Copyright © 2019 Andrea Stevanato All rights reserved.
//

import Foundation
import Bond

class UsersViewModel {
    
    // MARK: Observables
    
    let updateView = Observable<Bool>(false)
    
    // MARK: Properties
    
    let usersRepo = UsersRepo()
    fileprivate var users: [GHUser] = []
    
    // MARK: Methods
    
    func fecthUsers() {
        usersRepo.fetch(fromStorage: true, query: "language:swift") { [unowned self] (users) in
            self.users = users
            self.updateView.value = true
        }
    }
    
    func searchUsers(query: String) {
        usersRepo.fetch(fromStorage: false, query: query) { [unowned self] (users) in
            self.users = users
            self.updateView.value = true
        }
    }
    
    // Table view getter
    
    func numberOfUsers() -> Int {
        return users.count
    }
    
    func userAt(indexPath: IndexPath) -> GHUser {
        return users[indexPath.row]
    }
}
