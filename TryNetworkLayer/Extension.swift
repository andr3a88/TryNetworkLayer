//
//  Extension.swift
//  TryNetworkLayer
//
//  Created by Andrea Stevanato on 05/06/2018.
//  Copyright © 2018 Andrea Stevanato All rights reserved.
//

import Foundation

/// Convert json dictionary, data to Codable objects
public extension JSONDecoder {

    /// Convert json dictionary to Codable object
    ///
    /// - Parameters:
    ///   - json: Json dictionary.
    ///   - type: Type information.
    /// - Returns: Codable object
    /// - Throws: Error if failed
    static func decode<T: Codable>(_ json: [String: Any], to type: T.Type) throws -> T {
        let data = try JSONSerialization.data(withJSONObject: json, options: [])
        return try decode(data, to: type)
    }

    /// Convert json data to Codable object
    ///
    /// - Parameters:
    ///   - json: Json dictionary.
    ///   - type: Type information.
    /// - Returns: Codable object
    /// - Throws: Error if failed
    static func decode<T: Codable>(_ data: Data, to type: T.Type) throws -> T {
        try JSONDecoder().decode(T.self, from: data)
    }
}
