//
//  TryNetworkLayerTests.swift
//  TryNetworkLayerTests
//
//  Created by Andrea on 21/08/2017.
//  Copyright © 2017 Ennova Research Srl. All rights reserved.
//

import XCTest
@testable import TryNetworkLayer

class NetworkLayerTests: XCTestCase {
    
    let dispatcher = NetworkDispatcher(environment: Environment("Github", host: "https://api.github.com"))
    let usersTask = UsersTask(query: "language:swift")
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testSearchUser() {
        let expectedResult = expectation(description: "Async request")
        
        usersTask.execute(in: dispatcher) { (users, error) in
            XCTAssertEqual(users?.count, 30)
            expectedResult.fulfill()
        }
        waitForExpectations(timeout: 10, handler:nil)
    }
    
    //    func testSignIn() {
    //        let operation = SignInOperation(email: "a@b.com",
    //                                        password: "qwerty",
    //                                        service: MockSignInBackendService())
    //
    //        let expectedResult = expectation(description: "Async request")
    //
    //        operation.success = { item in
    //            let token = item.token
    //            let uniqueId = item.uniqueId
    //
    //            XCTAssertEqual(token, MockSignIn.token)
    //            XCTAssertEqual(uniqueId, MockSignIn.uniqueId)
    //
    //            expectedResult.fulfill()
    //        }
    //
    //        operation.failure = { error in
    //            XCTFail()
    //        }
    //
    //        NetworkQueue.shared.addOperation(operation)
    //
    //        waitForExpectations(timeout: 10, handler:nil)
    //    }
    //
    //    func testSignUp() {
    //        let expectedResult = expectation(description: "Async request")
    //
    //        let user = UserItem(firstName: MockSignUp.name,
    //                            lastName: MockSignUp.surname,
    //                            email: MockSignUp.email,
    //                            phoneNumber: nil)
    //
    //        let operation = SignUpOperation(user: user, password: "", service: MockSignUpBackendService())
    //
    //        operation.success = { item in
    //            XCTAssertEqual(item.firstName, MockSignUp.name)
    //            XCTAssertEqual(item.lastName, MockSignUp.surname)
    //            XCTAssertEqual(item.email, MockSignUp.email)
    //
    //            expectedResult.fulfill()
    //        }
    //
    //        operation.failure = { error in
    //            XCTFail()
    //        }
    //
    //        NetworkQueue.shared.addOperation(operation)
    //
    //        waitForExpectations(timeout: 10, handler:nil)
    //    }
    //
    //    func testShoppingMapper() {
    //        do {
    //            let map = try UserShoppingResponseMapper.process(MockUserShoppingResult().JSON())
    //            XCTAssertNotNil(map)
    //            XCTAssertTrue(map.count == 2)
    //        } catch {
    //            XCTFail()
    //        }
    //    }
    
}

extension XCTestCase {
    
    // Mock information to create requests and responses
    
    struct MockGHUser {
        static let organizationsUrl = "aaaa"
        static let score = 1.0
        static let reposUrl = "bbbb"
        
        func JSON() -> Any? {
            return ["organizations_url": MockGHUser.organizationsUrl,
                    "score": MockGHUser.score,
                    "repos_url": MockGHUser.reposUrl]
        }
    }
    
    
    //    class MockSignUpBackendService: BackendService {
    //        func request(_ request: BackendAPIRequest,
    //                     success: ((Any?) -> Void)?,
    //                     failure: ((NSError) -> Void)?) {
    //            success?(MockSignUp().JSON())
    //        }
    //
    //        internal func cancel() {}
    //    }
    
}
