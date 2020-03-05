//
//  UsersOperation.swift
//  TryNetworkLayer
//
//  Created by Andrea on 30/12/2019.
//  Copyright © 2019 Andrea Stevanato All rights reserved.
//

import Foundation

protocol UsersOperationType {
    var request: Request { get }
    var query: String { get set }
    
    init(query: String)
    func execute(in dispatcher: Dispatcher, completion: @escaping (Result<GHSearchResponse, Error>) -> Void)
}

final class UsersOperation: Operation, UsersOperationType {

    typealias D = Dispatcher
    typealias R = GHSearchResponse

    // MARK: Request parameters
    
    var query: String
    
    init(query: String) {
        self.query = query
    }
    
    var request: Request {
        UserRequests.searchUsers(query: self.query, perPage: 50, page: 1)
    }

    func execute(in dispatcher: Dispatcher, completion: @escaping (Result<GHSearchResponse, Error>) -> Void) {
        self.executeBaseResponse(dispatcher: dispatcher, completion: completion)
     }
}
