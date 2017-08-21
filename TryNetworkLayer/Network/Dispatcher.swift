//
//  Dispatcher.swift
//  TryNetworkLayer
//
//  Created by Andrea on 21/08/2017.
//  Copyright © 2017 Ennova Research Srl. All rights reserved.
//

import Foundation
import Alamofire

/// The dispatcher is responsible to execute a Request
/// by calling the underlyning layer (maybe URLSession, Alamofire
/// or just a fake dispatcher which return mocked results).
/// As output for a Request it should provide a Response.
public protocol Dispatcher {
    
    associatedtype Response
    
    /// Configure the dispatcher with an environment
    ///
    /// - Parameter environment: environment configuration
    init(environment: Environment)
    
    
    
    /// This function execute the request and provide a Promise
    /// with the response.
    ///
    /// - Parameter request: request to execute
    /// - Returns: promise
    func execute(request: Request) throws -> Response
    
}
