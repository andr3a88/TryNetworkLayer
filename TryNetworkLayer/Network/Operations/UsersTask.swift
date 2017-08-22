//
//  LoginOperation.swift
//  TryNetworkLayer
//
//  Created by Andrea on 21/08/2017.
//  Copyright © 2017 Ennova Research Srl. All rights reserved.
//

import Foundation
import ObjectMapper

class UsersTask: Operation {
    
    typealias D = Dispatcher
    typealias R = [GHUser]
    
    
    var query: String
    
    init(query: String) {
        self.query = query
    }
    
    var request: Request {
        return UserRequests.searchUsers(query: self.query)
    }
    
    func execute(in dispatcher: Dispatcher, completion: @escaping (_ user: [GHUser]?, _ error: Error?) -> Void) {
        do {
            try dispatcher.execute(request: self.request, completion: { (response: Response) in
                
                if let json = response.json, let object = Mapper<GHSearchResponse>().map(JSON: json) {
                    completion(object.items, nil)
                } else if let error = response.error {
                    completion(nil, error)
                }
            })
            
        } catch (let error) {
            print("Network error \(error.localizedDescription)")
        }
    }
}
