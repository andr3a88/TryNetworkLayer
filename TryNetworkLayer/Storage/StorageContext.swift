//
//  StorageContext.swift
//  TryNetworkLayer
//
//  Created by Andrea Stevanato on 02/09/2017.
//  Copyright © 2017 Ennova Research Srl. All rights reserved.
//

import Foundation

struct Sorted {
    var key: String
    var ascending: Bool = true
}

/// Operations available on storage context
protocol StorageContext {
    
    /// Create a new object with default values
    ///
    /// - Parameters:
    ///   - object: The object to create on Realm
    ///   - completion: The completion handler
    /// - Returns: An object that is conformed to the `Storable` protocol
    func create<T: Storable>(object: T, completion: @escaping ((T) -> Void)) throws
    
    /// Save an object
    ///
    /// - Parameter object: The object to save
    func save(object: Storable) throws
    
    /// Update an object
    ///
    /// - Parameter block: The update block
    func update(block: @escaping () -> Void) throws
    
    /// Delete an object
    ///
    /// - Parameter object: The object to delete
    func delete(object: Storable) throws
    
    /// Delete all objects
    ///
    /// - Parameter model: The model type of the objects to delete
    func deleteAll<T: Storable>(_ model: T.Type) throws
    
    /// A list of object to fetch from the storage
    ///
    /// - Parameters:
    ///   - model: The model type
    ///   - predicate: An optional predicate
    ///   - sorted: An optional sorting key
    ///   - completion: The completion handler
    func fetch<T: Storable>(_ model: T.Type, predicate: NSPredicate?, sorted: Sorted?, completion: (([T]) -> Void))
}
