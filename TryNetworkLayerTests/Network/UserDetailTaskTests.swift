//
//  UserDetailTaskTests.swift
//  TryNetworkLayer
//
//  Created by Andrea Stevanato on 03/09/2017.
//  Copyright © 2017 Ennova Research Srl. All rights reserved.
//

import XCTest
@testable import TryNetworkLayer

class UserDetailTaskTests: XCTestCase {
    
    let dispatcher = NetworkDispatcher(environment: Environment("Github", host: "https://api.github.com"))
    
    let userDetailTask = UserDetailTask(username: "andr3a88")
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testUserDetailTask() {
        let expectedResult = expectation(description: "Async real request")
        
        userDetailTask.execute(in: dispatcher) { (user, error) in
            XCTAssertEqual(user?.login, "andr3a88")
            expectedResult.fulfill()
        }
        waitForExpectations(timeout: 10, handler:nil)
    }
}
