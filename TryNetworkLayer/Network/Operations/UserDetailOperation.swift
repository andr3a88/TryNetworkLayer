//
//  UserDetailOperation.swift
//  TryNetworkLayer
//
//  Created by Andrea Stevanato on 03/09/2017.
//  Copyright © 2019 Andrea Stevanato All rights reserved.
//

import Foundation

protocol UserDetailOperationType {
    var username: String { get set }
    var request: Request { get }

    init(username: String)
    func execute(in dispatcher: Dispatcher, completion: @escaping (Result<GHUserDetail, Error>) -> Void) 
}

final class UserDetailOperation: Operation, UserDetailOperationType {

    typealias D = Dispatcher
    typealias R = GHUserDetail
    
    // MARK: Request parameters

    var username: String
    
    init(username: String) {
        self.username = username
    }
    
    var request: Request {
        UserRequests.detail(username: username)
    }
    
    func execute(in dispatcher: Dispatcher, completion: @escaping (Result<GHUserDetail, Error>) -> Void) {
        self.executeBaseResponse(dispatcher: dispatcher, completion: completion)
    }
}
