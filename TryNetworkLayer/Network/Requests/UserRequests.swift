//
//  UserRequests.swift
//  TryNetworkLayer
//
//  Created by Andrea on 21/08/2017.
//  Copyright © 2017 Ennova Research Srl. All rights reserved.
//

import Foundation

public enum UserRequests: Request {
    
    case detail(username: String)
    case searchUsers(query: String)
    
    public var path: String {
        switch self {
        case .detail(let username):
            return "users/\(username)"
        case .searchUsers(_):
            return "search/users"
        }
    }
    
    public var method: HTTPMethod {
        switch self {
        case .detail(_):
            return .get
        case .searchUsers(_):
            return .get
        }
    }
    
    public var parameters: RequestParams? {
        switch self {
        case .detail(_):
            return .url([:])
        case .searchUsers(let query):
            return .url(["q" : query])
        }
    }
    
    public var headers: [String : Any]? {
        switch self {
        default:
            return nil
        }
    }
    
    public var dataType: DataType {
        switch self {
        case .detail(_):
            return .JSON
        case .searchUsers(_):
            return .JSON
        }
    }
}
