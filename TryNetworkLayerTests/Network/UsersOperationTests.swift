//
//  TryNetworkLayerTests.swift
//  TryNetworkLayerTests
//
//  Created by Andrea on 30/12/2019.
//  Copyright © 2019 Andrea Stevanato All rights reserved.
//

import XCTest
@testable import TryNetworkLayer

class UsersOperationTests: XCTestCase {
    
    let dispatcher = NetworkDispatcher(environment: TestUtils.Env.default)
    let sut = UsersOperation(query: "language:swift")
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testSearchResponseMapper() {
        let object = try! JSONDecoder.decode(MockSearchResponse().JSON(), to: GHSearchResponse.self)
        
        XCTAssertNotNil(object)
        XCTAssertFalse(object.incompleteResults)
        XCTAssertEqual(object.totalCount, 800)
        XCTAssertEqual(object.items.count, 2)
        
    }
    
    func testUserMapper() {
        let object = try! JSONDecoder.decode( MockGHUser(id: 1).JSON(), to: GHUser.self)
        
        XCTAssertNotNil(object)
        XCTAssertEqual(object.organizationsUrl!, "url")
        XCTAssertEqual(object.score, 1)
        XCTAssertEqual(object.reposUrl!, "url")
        XCTAssertEqual(object.htmlUrl!, "url")
        XCTAssertEqual(object.gravatarId!, "id")
        XCTAssertEqual(object.avatarUrl!, "url")
        XCTAssertEqual(object.type!, "user")
        XCTAssertEqual(object.login, "url")
        XCTAssertEqual(object.followersUrl!, "url")
        XCTAssertEqual(object.id, 1)
        XCTAssertEqual(object.receivedEventsUrl!, "url")
        XCTAssertEqual(object.subscriptionsUrl!, "url")
        XCTAssertEqual(object.url!, "url")
    }
    
    func testMockSearchUserTask() {
        let expectedResult = expectation(description: "Async mocked request")
        
        sut.execute(in: dispatcher) { result in
            switch result {
            case .success(let response):
                XCTAssertEqual(response.items.count, 50)
                expectedResult.fulfill()
            case .failure(let error):
                XCTFail("\(error.localizedDescription)")
            }
        }
        waitForExpectations(timeout: 10, handler:nil)
    }
}
