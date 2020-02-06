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
    case searchUsers(query: String)
    
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
    
    public var parameters: RequestParams? {
        switch self {
        case .detail:
            return .url([:])
        case .searchUsers(let query):
            return .url(["q": query])
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
