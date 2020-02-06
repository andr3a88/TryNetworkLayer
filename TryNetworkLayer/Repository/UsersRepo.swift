//
//  UsersRepository.swift
//  TryNetworkLayer
//
//  Created by Andrea Stevanato on 02/09/2017.
//  Copyright © 2019 Andrea Stevanato All rights reserved.
//

import Foundation

protocol UsersRepoProtocol {
    func fetch(fromStorage: Bool, query: String, block: @escaping (_ users: [GHUser]) -> Void)
    func fetchDetail(username: String, block: @escaping (_ user: GHUserDetail?) -> Void)
    func create(user: GHUser)
    func create(userDetail: GHUserDetail)
    func update(block: @escaping () -> Void)
    func delete(user: GHUser)
}

final class UsersRepo: UsersRepoProtocol {
    
    fileprivate var storage: StorageContext?
    fileprivate let dispatcher = NetworkDispatcher(environment: Environment("Github", host: "https://api.github.com"))
    
    fileprivate let usersTask = UsersTask(query: "")
    fileprivate let userDetailTask = UserDetailTask(username: "")
    
    init() {
        self.storage = try! RealmStorageContext(configuration: ConfigurationType.basic(identifier: "database"))
    }
    
    func fetchDetail(username: String, block: @escaping (_ user: GHUserDetail?) -> Void) {
        userDetailTask.username = username
        userDetailTask.execute(in: dispatcher) { [unowned self] (user, error) in
            
            if let user = user {
                self.create(userDetail: user)
                block(user)
            } else if let error = error {
                print("\(String(describing: error.localizedDescription))")
            }
        }
    }
    
    func fetch(fromStorage: Bool = true, query: String, block: @escaping (_ users: [GHUser]) -> Void) {
        
        if fromStorage {
            let sort = Sorted(key: "login", ascending: false)
            self.storage?.fetch(GHUser.self, predicate: nil, sorted: sort, completion: { (users) in
                block(users)
            })
            return
        }
        
        usersTask.query = query
        usersTask.execute(in: dispatcher) { [unowned self] (users, error) in
            
            if let users = users {
                for user in users {
                    self.create(user: user)
                }
                block(users)
            } else if let error = error {
                print("\(String(describing: error.localizedDescription))")
            }
        }
    }
    
    func create(user: GHUser) {
        do {
            try self.storage?.create(object: user, completion: { _ in
            })
        } catch _ as NSError {
        }
    }
    
    func create(userDetail: GHUserDetail) {
        do {
            try self.storage?.create(object: userDetail, completion: { _ in
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
