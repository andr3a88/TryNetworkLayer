//
//  Response.swift
//  TryNetworkLayer
//
//  Created by Andrea on 21/08/2017.
//  Copyright © 2017 Ennova Research Srl. All rights reserved.
//

import Foundation
import Alamofire

public class Response {
    
    public typealias JSON = [String: Any]
    
    var json: JSON?
    var data: Data?
    var error: Error?
    
    init(_ dataResponse: DataResponse<Any>, for request: Request) {
        
        guard dataResponse.response?.statusCode == 200, dataResponse.error == nil else {
            self.error = dataResponse.error
            return
        }
        guard let data = dataResponse.data else {
            self.error = NetworkErrors.noData
            return
        }
        guard let json = dataResponse.result.value as? JSON else {
            self.error = NetworkErrors.noData
            return
        }
        
        switch request.dataType {
        case .Data:
            self.data = data
        case .JSON:
            self.json = json
        }
    }
}
