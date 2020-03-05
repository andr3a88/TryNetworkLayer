//
//  UserRequests.swift
//  TryNetworkLayer
//
//  Created by Andrea on 30/12/2019.
//  Copyright © 2019 Andrea Stevanato All rights reserved.
//

import Foundation

public enum UserRequests: Request {
    
    case detail(username: String)
    case searchUsers(query: String, perPage: Int, page: Int)
    
    public var path: String {
        switch self {
        case .detail(let username):
            return "users/\(username)"
        case .searchUsers:
            return "search/users"
        }
    }
    
    public var method: HTTPMethod {
        switch self {
        case .detail:
            return .get
        case .searchUsers:
            return .get
        }
    }
    
    public var parameters: RequestParameters? {
        switch self {
        case .detail:
            return .url([:])
        case .searchUsers(let query, let perPage, let page):
            return .url(["q": query,
                         "per_page": String(perPage),
                         "page": String(page)])
        }
    }
    
    public var headers: [String: Any]? {
        switch self {
        default:
            return nil
        }
    }
    
    public var dataType: DataType {
        switch self {
        case .detail:
            return .JSON
        case .searchUsers:
            return .JSON
        }
    }
}
