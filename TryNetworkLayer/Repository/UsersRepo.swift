//
//  UsersRepository.swift
//  TryNetworkLayer
//
//  Created by Andrea Stevanato on 02/09/2017.
//  Copyright © 2017 Ennova Research Srl. All rights reserved.
//

import Foundation

protocol UsersRepoProtocol {
    func fetch(block: @escaping (_ users: [GHUser]) -> Void)
    func create(user: GHUser)
    func update(block: @escaping () -> Void)
    func delete(user: GHUser)
}

final class UsersRepo: UsersRepoProtocol {
    
    fileprivate var storage: StorageContext?
    fileprivate let dispatcher = NetworkDispatcher(environment: Environment("Github", host: "https://api.github.com"))
    fileprivate let usersTask = UsersTask(query: "language:swift")
    
    init() {
        self.storage = try! RealmStorageContext(configuration: ConfigurationType.basic(identifier: "database"))
    }
    
    func fetch(block: @escaping (_ users: [GHUser]) -> Void) {
        
        usersTask.execute(in: dispatcher) { [unowned self] (users, error) in
            
            if let users = users {
                for user in users {
                    print("\(String(describing: user.login))")
                    self.create(user: user)
                }
                let sort = Sorted(key: "id", ascending: false)
                self.storage?.fetch(GHUser.self, predicate: nil, sorted: sort, completion: { (users) in
                    block(users)
                })
            } else if let error = error {
                print("\(String(describing: error.localizedDescription))")
            }
        }
    }
    
    func create(user: GHUser) {
        do {
            try self.storage?.create(object: user, completion: { (user) in
            })
        } catch _ as NSError {
        }
    }
    
    func update(block: @escaping () -> Void) {
        do {
            try self.storage?.update(block: {
                block()
            })
        } catch _ as NSError {
        }
    }
    
    func delete(user: GHUser) {
        do {
            try self.storage?.delete(object: user)
        } catch _ as NSError {
        }
    }
}
