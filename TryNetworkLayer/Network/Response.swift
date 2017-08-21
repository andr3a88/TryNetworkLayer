//
//  Response.swift
//  TryNetworkLayer
//
//  Created by Andrea on 21/08/2017.
//  Copyright © 2017 Ennova Research Srl. All rights reserved.
//

import Foundation
import SwiftyJSON

/// Parse the Response
public enum Response {
    case json(_: JSON)
    case data(_: Data)
    case error(_: Int?, _: Error?)
    
    init(_ response: (r: HTTPURLResponse?, data: Data?, error: Error?), for request: Request) {
        guard response.r?.statusCode == 200, response.error == nil else {
            self = .error(response.r?.statusCode, response.error)
            return
        }
        
        guard let data = response.data else {
            self = .error(response.r?.statusCode, NetworkErrors.noData)
            return
        }
        
        switch request.dataType {
        case .Data:
            self = .data(data)
        case .JSON:
            self = .json(JSON(data: data))
        }
    }
}
