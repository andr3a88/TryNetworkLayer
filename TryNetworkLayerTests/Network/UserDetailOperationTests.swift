//
//  UserDetailTaskTests.swift
//  TryNetworkLayer
//
//  Created by Andrea Stevanato on 03/09/2017.
//  Copyright © 2019 Andrea Stevanato All rights reserved.
//

import XCTest
@testable import TryNetworkLayer

class UserDetailOperationTests: XCTestCase {
    
    let dispatcher = NetworkDispatcher(environment: TestUtils.Env.default)
    let sut = UserDetailOperation(username: "andr3a88")
    
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
        
        sut.execute(in: dispatcher) { result in

            switch result {
            case .success(let user):
                XCTAssertEqual(user.login, "andr3a88")
                expectedResult.fulfill()
            case .failure(let error):
                XCTFail("\(error.localizedDescription)")
            }

        }
        waitForExpectations(timeout: 10, handler:nil)
    }
}
