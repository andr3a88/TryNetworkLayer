//
//  UsersRepository.swift
//  TryNetworkLayer
//
//  Created by Andrea Stevanato on 02/09/2017.
//  Copyright © 2019 Andrea Stevanato All rights reserved.
//

import Foundation

protocol UsersRepoProtocol {
    var storage: StorageContext { get }
    var dispatcher: Dispatcher { get }
    var usersOperation: UsersOperationType { get set }
    var userDetailOperation: UserDetailOperationType { get set }

    func fetch(fromStorage: Bool, query: String, block: @escaping (_ users: [GHUser]) -> Void)
    func fetchDetail(username: String, block: @escaping (_ user: GHUserDetail?) -> Void)
    func create(user: GHUser)
    func create(userDetail: GHUserDetail)
    func update(block: @escaping () -> Void)
    func delete(user: GHUser)
    func deleteAll()
}

final class UsersRepo: UsersRepoProtocol {

    private(set) var storage: StorageContext
    private(set) var dispatcher: Dispatcher
    
    var usersOperation: UsersOperationType
    var userDetailOperation: UserDetailOperationType
    
    init() {
        do {
            self.storage = try RealmStorageContext(configuration: ConfigurationType.basic(identifier: "database"))
        } catch let error {
            print("\(error.localizedDescription)")
            fatalError("Cannot initialize Storage Context")
        }
        self.dispatcher = NetworkDispatcher(environment: Environment("Github", host: "http://localhost:3900"))
        self.usersOperation = UsersOperation(query: "")
        self.userDetailOperation = UserDetailOperation(username: "")
    }
    
    func fetchDetail(username: String, block: @escaping (_ user: GHUserDetail?) -> Void) {
        userDetailOperation.username = username
        userDetailOperation.execute(in: dispatcher) { [weak self] result in
            switch result {
            case .success(let user):
                self?.create(userDetail: user)
                block(user)
            case .failure(let error):
                print("\(String(describing: error.localizedDescription))")
            }
        }
    }
    
    func fetch(fromStorage: Bool = true, query: String, block: @escaping (_ users: [GHUser]) -> Void) {
        
        if fromStorage {
            let sort = Sorted(key: "login", ascending: false)
            self.storage.fetch(GHUser.self, predicate: nil, sorted: sort, completion: { (users) in
                block(users)
            })
            return
        }
        
        usersOperation.query = query
        usersOperation.execute(in: dispatcher) { [weak self] result in
            switch result {
            case .success(let response):
                for user in response.items {
                    self?.create(user: user)
                }
                block(response.items)
            case .failure(let error):
                print("\(String(describing: error.localizedDescription))")
            }
        }
    }
    
    func create(user: GHUser) {
        do {
            try self.storage.create(object: user, completion: { _ in
            })
        } catch _ as NSError {
        }
    }
    
    func create(userDetail: GHUserDetail) {
        do {
            try self.storage.create(object: userDetail, completion: { _ in
            })
        } catch _ as NSError {
        }
    }
    
    func update(block: @escaping () -> Void) {
        do {
            try self.storage.update(block: {
                block()
            })
        } catch _ as NSError {
        }
    }
    
    func delete(user: GHUser) {
        do {
            try self.storage.delete(object: user)
        } catch _ as NSError {
        }
    }

    func deleteAll() {
        do {
            try self.storage.deleteAll(GHUser.self)
        } catch _ as NSError {
        }
    }
}
