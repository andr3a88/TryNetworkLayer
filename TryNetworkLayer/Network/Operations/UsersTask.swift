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
    
    var request: Request {
        return UserRequests.users
    }
    
    func execute(in dispatcher: Dispatcher, completion: @escaping (_ user: [GHUser]?, _ error: Error?) -> Void) {
        do {
            try dispatcher.execute(request: self.request, completion: { (response: Response) in
                
                if let object = Mapper<GHUser>().mapArray(JSONObject: response.json) {
                    completion(object, nil)
                } else if let error = response.error {
                    completion(nil, error)
                }
            })
            
        } catch (let error) {
            print("Network error \(error.localizedDescription)")
        }
    }
}
