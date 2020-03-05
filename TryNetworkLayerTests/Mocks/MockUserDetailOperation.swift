//
//  MockUserDetailOperation.swift
//  TryNetworkLayerTests
//
//  Created by Andrea Stevanato on 05/03/2020.
//  Copyright © 2020 Andrea Stevanato. All rights reserved.
//

import Foundation
@testable import TryNetworkLayer

class MockUserDetailOperation: UserDetailOperationType {

    typealias D = Dispatcher
    typealias R = GHUserDetail

    // MARK: Request parameters
    var username: String

    required init(username: String) {
        self.username = username
    }

    var request: Request {
        return UserRequests.searchUsers(query: self.username, perPage: 50, page: 1)
    }

    func execute(in dispatcher: Dispatcher, completion: @escaping (Result<GHUserDetail, Error>) -> Void) {
        completion(.success(GHUserDetail()))
    }
}
