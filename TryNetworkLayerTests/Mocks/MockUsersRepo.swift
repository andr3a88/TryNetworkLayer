//
//  MockUsersRepo.swift
//  TryNetworkLayerTests
//
//  Created by Andrea Stevanato on 05/03/2020.
//  Copyright © 2020 Andrea Stevanato. All rights reserved.
//

import Foundation
@testable import TryNetworkLayer

class MockUsersRepo: UsersRepoProtocol {

    var storage: StorageContext = try! RealmStorageContext(configuration: ConfigurationType.inMemory(identifier: "test"))
    var dispatcher: Dispatcher = NetworkDispatcher(environment: Environment("Github", host: "mock"))

    var usersOperation: UsersOperationType = MockUserOperation(query: "language:swift")
    var userDetailOperation: UserDetailOperationType = MockUserDetailOperation(username: "andr3a88")

    func fetch(fromStorage: Bool = true, query: String, block: @escaping (_ users: [GHUser]) -> Void) {

        if fromStorage {
            let sort = Sorted(key: "login", ascending: false)
            self.storage.fetch(GHUser.self, predicate: nil, sorted: sort, completion: { (users) in
                block(users)
            })
            return
        }

        usersOperation.query = query
        usersOperation.execute(in: dispatcher) { [unowned self] result in
            switch result {
            case .success(let response):
                for user in response.items {
                    self.create(user: user)
                }
                block(response.items)
            case .failure(let error):
                print("\(String(describing: error.localizedDescription))")
            }
        }
    }

    func create(user: GHUser) {
        do {
            try self.storage.create(object: user, completion: { (user) in
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

    func fetchDetail(username: String, block: @escaping (GHUserDetail?) -> Void) {

    }

    func create(userDetail: GHUserDetail) {

    }

    func deleteAll() {
    }
}
