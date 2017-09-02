//
//  UsersRepoTests.swift
//  TryNetworkLayer
//
//  Created by Andrea Stevanato on 02/09/2017.
//  Copyright © 2017 Ennova Research Srl. All rights reserved.
//

import XCTest
@testable import TryNetworkLayer

class MockUsersRepo: UsersRepoProtocol {
    
    let storage = try! RealmStorageContext(configuration: ConfigurationType.inMemory(identifier: "test"))
    let dispatcher = NetworkDispatcher(environment: Environment("Github", host: "mock"))
    
    let usersTask = MockUserTask(query: "language:swift")
    
    func fetch(block: @escaping (_ users: [GHUser]) -> Void) {
        
        usersTask.execute(in: dispatcher) { [unowned self] (users, error) in
            
            if let users = users {
                for user in users {
                    print("\(String(describing: user.login))")
                    self.create(user: user)
                }
                let sort = Sorted(key: "id", ascending: false)
                self.storage.fetch(GHUser.self, predicate: nil, sorted: sort, completion: { (users) in
                    block(users)
                })
            } else if let error = error {
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
}

class UsersRepoTests: XCTestCase {
    
    let mockUsersRepo = MockUsersRepo()
    let usersRepo = UsersRepo()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testMockFetch() {
        let expectedResult = expectation(description: "Async mock request")
        
        mockUsersRepo.fetch { (users) in
            XCTAssertEqual(users.count, 2)
            expectedResult.fulfill()
        }
        waitForExpectations(timeout: 10, handler:nil)
    }
    
    func testRealFetch() {
        let expectedResult = expectation(description: "Async real request")
        
        usersRepo.fetch { (users) in
            XCTAssertEqual(users.count, 30)
            expectedResult.fulfill()
        }
        waitForExpectations(timeout: 10, handler:nil)
    }
}
