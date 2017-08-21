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
    case avatar(username: String)
    
    public var path: String {
        switch self {
        case .login(_,_):
            return "/users/login"
        case .avatar(_):
            return "/usets/avatar"
        }
    }
    
    public var method: HTTPMethod {
        switch self {
        case .login(_,_):
            return .post
        case .avatar(_):
            return .get
        }
    }
    
    public var parameters: RequestParams {
        switch self {
        case .login(let username, let password):
            return .body(["user" : username, "pass" : password])
        case .avatar(let username):
            return .url(["username" : username])
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
        case .login(_,_):
            return .JSON
        case .avatar(_):
            return .Data
        }
    }
}
