//
//  MockUserOperation.swift
//  TryNetworkLayerTests
//
//  Created by Andrea Stevanato on 05/03/2020.
//  Copyright © 2020 Andrea Stevanato. All rights reserved.
//

import Foundation
@testable import TryNetworkLayer

class MockUserOperation: UsersOperationType {

    typealias D = Dispatcher
    typealias R = GHSearchResponse

    // MARK: Request parameters
    var query: String

    required init(query: String) {
        self.query = query
    }

    var request: Request {
        return UserRequests.searchUsers(query: self.query, perPage: 50, page: 1)
    }

    func execute(in dispatcher: Dispatcher, completion: @escaping (Result<GHSearchResponse, Error>) -> Void) {

        let object1 = try! JSONDecoder.decode( MockGHUser(id: 1).JSON(), to: GHUser.self)
        let object2 = try! JSONDecoder.decode( MockGHUser(id: 2).JSON(), to: GHUser.self)
        let response = GHSearchResponse()
        response.items = [object1, object2]
        completion(.success(response))
    }
}
