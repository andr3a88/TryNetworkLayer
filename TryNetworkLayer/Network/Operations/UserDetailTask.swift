//
//  File.swift
//  TryNetworkLayer
//
//  Created by Andrea Stevanato on 03/09/2017.
//  Copyright © 2019 Andrea Stevanato All rights reserved.
//

import Foundation

class UserDetailTask: Operation {
    
    typealias D = Dispatcher
    typealias R = GHUserDetail
    
    // MARK: Request parameters
    var username: String
    
    init(username: String) {
        self.username = username
    }
    
    var request: Request {
        return UserRequests.detail(username: username)
    }
    
    func execute(in dispatcher: Dispatcher, completion: @escaping (_ user: GHUserDetail?, _ error: Error?) -> Void) {
        do {
            try dispatcher.execute(request: self.request, completion: { (response: Response) in
                if let json = response.json {
                    do {
                        let object = try JSONDecoder.decode(json, to: GHUserDetail.self)
                        completion(object, nil)
                    } catch let error {
                        completion(nil, error)
                    }
                } else if let error = response.error {
                    completion(nil, error)
                }
            })
        } catch let error {
            print("Network error \(error.localizedDescription)")
        }
    }
}
