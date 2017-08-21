//
//  LoginOperation.swift
//  TryNetworkLayer
//
//  Created by Andrea on 21/08/2017.
//  Copyright © 2017 Ennova Research Srl. All rights reserved.
//

import Foundation

class User {
    
    init() {
    }
    
}

class LoginTask<User>: Operation {
    
    var username: String
    var password: String
    
    init(user: String, password: String) {
        self.username = user
        self.password = password
    }
    
    var request: Request {
        return UserRequests.login(username: self.username, password: self.password)
    }
    
    func execute(in dispatcher: Dispatcher) -> User {
        return User()
    }
}
