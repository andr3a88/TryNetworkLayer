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

    associatedtype D = Dispatcher // Default value
    associatedtype R
    
    /// Request to execute
    var request: Request { get }
    
    /// Execute request in passed dispatcher
    ///
    /// - Parameter dispatcher: dispatcher
    func execute(in dispatcher: D, completion: @escaping (Result<R, Error>) -> Void)
}

extension Operation {

    /// Execute a request that has response of generic type `T`
    ///
    /// - Parameters:
    ///   - dispatcher: The dispatcher
    ///   - completion: The completion handler
    func executeBaseResponse<T: Codable>(dispatcher: Dispatcher, completion: @escaping (Result<T, Error>) -> Void) {
        do {
            try dispatcher.execute(request: self.request, completion: { (response: Response) in

                if let json = response.json {
                    let decoder = JSONDecoder()
                    do {
                        let response = try decoder.decode(T.self, from: json)
                        completion(.success(response))
                    } catch let error {
                        completion(.failure(error))
                    }
                } else if let error = response.error {
                    completion(.failure(error))
                }
            })
        } catch let error {
            completion(.failure(error))
        }
    }

    /// Execute a request that has response of type `BaseDataArrayResponse<T>`
    ///
    /// - Parameters:
    ///   - dispatcher: The dispatcher
    ///   - completion: The completion handler
    func executeBaseArrayResponse<T: Codable>(dispatcher: Dispatcher, completion: @escaping (Result<[T], Error>) -> Void) {
        do {
            try dispatcher.execute(request: self.request, completion: { (response: Response) in

                if let json = response.json {
                    let decoder = JSONDecoder()
                    do {
                        let response = try decoder.decode([T].self, from: json)
                        completion(.success(response))
                    } catch let error {
                        completion(.failure(error))
                    }
                } else if let error = response.error {
                    completion(.failure(error))
                }
            })
        } catch let error {
            completion(.failure(error))
        }
    }
}

private extension JSONDecoder {

    func decode<T>(_ type: T.Type, from json: Response.JSON) throws -> T where T: Decodable {
        let data = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
        return try self.decode(type, from: data)
    }
}
