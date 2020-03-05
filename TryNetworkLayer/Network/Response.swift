//
//  Response.swift
//  TryNetworkLayer
//
//  Created by Andrea on 30/12/2019.
//  Copyright © 2019 Andrea Stevanato All rights reserved.
//

import Alamofire
import Foundation

public class Response {
    
    public typealias JSON = [String: Any]
    
    var json: JSON?
    var data: Data?
    var error: Error?
    
    init(_ dataResponse: AFDataResponse<Any>, for request: Request) {

        // response validation
        guard let statusCode = dataResponse.response?.statusCode else {
            self.error = dataResponse.error
            return
        }
        if statusCode == 401, dataResponse.error == nil {
            self.error = NetworkError.notAuthorized
            return
        }
        if statusCode == 403, dataResponse.error == nil {
            self.error = NetworkError.forbidden
            return
        }
        guard Array(200 ... 299).contains(statusCode), dataResponse.error == nil else {
            self.error = dataResponse.error
            return
        }
        guard let data = dataResponse.data else {
            self.error = NetworkError.noData
            return
        }
        guard let json = dataResponse.value as? JSON else {
            self.error = NetworkError.noData
            return
        }
        
        switch request.dataType {
        case .data:
            self.data = data
        case .JSON:
            self.json = json
        }
    }
}
