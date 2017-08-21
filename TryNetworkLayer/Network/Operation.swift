//
//  Operation.swift
//  TryNetworkLayer
//
//  Created by Andrea on 21/08/2017.
//  Copyright © 2017 Ennova Research Srl. All rights reserved.
//

import Foundation

protocol Operation {
    
    associatedtype Output
    
    /// Request to execute
    var request: Request { get }
    

    /// Execute request in passed dispatcher
    ///
    /// - Parameter dispatcher: dispatcher
    /// - Returns: a promise
    func execute(in dispatcher: Dispatcher) -> Output
    
}
