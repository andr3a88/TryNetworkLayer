//
//  UserRequests.swift
//  TryNetworkLayer
//
//  Created by Andrea on 21/08/2017.
//  Copyright © 2017 Ennova Research Srl. All rights reserved.
//

import Foundation

public enum UserRequests: Request {
    
    case login(username: String, password: String)
    case searchUsers(query: String)
    
    public var path: String {
        switch self {
        case .login(_, _):
            return "login"
        case .searchUsers(_):
            return "search/users"
        }
    }
    
    public var method: HTTPMethod {
        switch self {
        case .login(_, _):
            return .post
        case .searchUsers(_):
            return .get
        }
    }
    
    public var parameters: RequestParams? {
        switch self {
        case .login(let username, let password):
            return .body(["user" : username, "pass" : password])
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
        case .login(_, _):
            return .JSON
        case .searchUsers(_):
            return .JSON
        }
    }
}
