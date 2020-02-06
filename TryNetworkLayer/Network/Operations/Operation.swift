//
//  Operation.swift
//  TryNetworkLayer
//
//  Created by Andrea on 30/12/2019.
//  Copyright © 2019 Andrea Stevanato All rights reserved.
//

import Foundation

enum OperationErrors: Error {
    case badMapping
}

protocol Operation {
    
    associatedtype D
    associatedtype R
    
    /// Request to execute
    var request: Request { get }
    
    /// Execute request in passed dispatcher
    ///
    /// - Parameter dispatcher: dispatcher
    func execute(in dispatcher: D, completion: @escaping (_ result: R?, _ error: Error?) -> Void)
}
