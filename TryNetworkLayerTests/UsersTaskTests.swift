//
//  TryNetworkLayerTests.swift
//  TryNetworkLayerTests
//
//  Created by Andrea on 21/08/2017.
//  Copyright © 2017 Ennova Research Srl. All rights reserved.
//

import XCTest
import ObjectMapper
@testable import TryNetworkLayer

class UsersTaskTests: XCTestCase {
    
    let dispatcher = NetworkDispatcher(environment: Environment("Github", host: "https://api.github.com"))
    let usersTask = UsersTask(query: "language:swift")
    
    let mockUserTask = MockUserTask(query: "language:swift")
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testSearchResponseMapper() {
        let object = Mapper<GHSearchResponse>().map(JSON: MockSearchResponse().JSON())!
        
        XCTAssertNotNil(object)
        XCTAssertFalse(object.incompleteResults!)
        XCTAssertEqual(object.totalCount!, 800)
        XCTAssertEqual(object.items?.count, 2)
        
    }
    
    func testUserMapper() {
        let object = Mapper<GHUser>().map(JSON: MockGHUser().JSON())!
        
        XCTAssertNotNil(object)
        XCTAssertEqual(object.organizationsUrl!, "url")
        XCTAssertEqual(object.score!, 1)
        XCTAssertEqual(object.reposUrl!, "url")
        XCTAssertEqual(object.htmlUrl!, "url")
        XCTAssertEqual(object.gravatarId!, "id")
        XCTAssertEqual(object.avatarUrl!, "url")
        XCTAssertEqual(object.type!, "user")
        XCTAssertEqual(object.login!, "url")
        XCTAssertEqual(object.followersUrl!, "url")
        XCTAssertEqual(object.id!, 123456)
        XCTAssertEqual(object.receivedEventsUrl!, "url")
        XCTAssertEqual(object.subscriptionsUrl!, "url")
        XCTAssertEqual(object.url!, "url")
    }
    
    func testMockSearchUserTask() {
        let expectedResult = expectation(description: "Async mocked request")
        
        usersTask.execute(in: dispatcher) { (users, error) in
            XCTAssertEqual(users?.count, 30)
            expectedResult.fulfill()
        }
        waitForExpectations(timeout: 10, handler:nil)
    }
    
    func testSearchUserTask() {
        let expectedResult = expectation(description: "Async request")
        
        mockUserTask.execute(in: dispatcher) { (users, error) in
            XCTAssertEqual(users?.count, 2)
            expectedResult.fulfill()
        }
        waitForExpectations(timeout: 10, handler:nil)
    }
}

struct MockSearchResponse {
    static let incompleteResults = false
    static let totalCount = 800
    static let items = [MockGHUser().JSON(), MockGHUser().JSON()]
    
    func JSON() -> [String: Any] {
        return ["incomplete_results": MockSearchResponse.incompleteResults,
                "total_count": MockSearchResponse.totalCount,
                "items": MockSearchResponse.items]
    }
}

struct MockGHUser {
    static let organizationsUrl = "url"
    static let score = 1
    static let reposUrl = "url"
    static let htmlUrl = "url"
    static let gravatarId = "id"
    static let avatarUrl = "url"
    static let type = "user"
    static let login = "url"
    static let followersUrl = "url"
    static let id = 123456
    static let subscriptionsUrl = "url"
    static let receivedEventsUrl = "url"
    static let url = "url"
    
    func JSON() -> [String: Any] {
        return ["organizations_url": MockGHUser.organizationsUrl,
                "score": MockGHUser.score,
                "repos_url": MockGHUser.reposUrl,
                "html_url": MockGHUser.htmlUrl,
                "gravatar_id": MockGHUser.gravatarId,
                "avatar_url": MockGHUser.avatarUrl,
                "type": MockGHUser.type,
                "login": MockGHUser.login,
                "followers_url": MockGHUser.followersUrl,
                "id": MockGHUser.id,
                "subscriptions_url": MockGHUser.subscriptionsUrl,
                "received_events_url": MockGHUser.receivedEventsUrl,
                "url": MockGHUser.url]
    }
}

class MockUserTask: TryNetworkLayer.Operation {
    
    typealias D = Dispatcher
    typealias R = [GHUser]
    
    // MARK: Request parameters
    var query: String
    
    init(query: String) {
        self.query = query
    }
    
    var request: Request {
        return UserRequests.searchUsers(query: self.query)
    }
    
    func execute(in dispatcher: Dispatcher, completion: @escaping (_ user: [GHUser]?, _ error: Error?) -> Void) {
        let object = Mapper<GHUser>().map(JSON: MockGHUser().JSON())!
        completion([object, object], nil)
    }
}
