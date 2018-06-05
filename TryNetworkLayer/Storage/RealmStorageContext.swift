//
//  RealmStorageContext.swift
//  TryNetworkLayer
//
//  Created by Andrea Stevanato on 02/09/2017.
//  Copyright © 2017 Ennova Research Srl. All rights reserved.
//

import Foundation
import RealmSwift

/// Realm configuration type
public enum ConfigurationType {
    case basic(identifier: String?)
    case inMemory(identifier: String?)
    
    var associated: String? {
        switch self {
        case .basic(let identifier): return identifier
        case .inMemory(let identifier): return identifier
        }
        
    }
}

class RealmStorageContext: StorageContext {
    var realm: Realm?
    
    static fileprivate let schemaVersion: UInt64 = 1
    
    required init(configuration: ConfigurationType = .basic(identifier: nil)) throws {
        var rmConfig = Realm.Configuration()
        rmConfig.readOnly = false
        switch configuration {
        case .basic:
            rmConfig = Realm.Configuration.defaultConfiguration
            if let identifier = configuration.associated {
                
                rmConfig.fileURL = RealmStorageContext.getPath(identifier) as URL?
                rmConfig.schemaVersion = RealmStorageContext.schemaVersion
                rmConfig.migrationBlock = { migration, oldSchemaVersion in
                    if oldSchemaVersion < RealmStorageContext.schemaVersion {
                    }
                }
            }
        case .inMemory:
            rmConfig = Realm.Configuration()
            if let identifier = configuration.associated {
                rmConfig.inMemoryIdentifier = identifier
            } else {
                throw NSError()
            }
        }
        print("\(rmConfig.fileURL?.absoluteString ?? "Realm in memory")")
        try self.realm = Realm(configuration: rmConfig)
    }
    
    public func safeWrite(_ block: (() throws -> Void)) throws {
        guard let realm = self.realm else {
            throw NSError()
        }
        
        if realm.isInWriteTransaction {
            try block()
        } else {
            try realm.write(block)
        }
    }
    
    func create<T: Storable>(object: T, completion: @escaping ((T) -> Void)) throws {
        guard let realm = self.realm else {
            throw NSError()
        }
        
        try self.safeWrite {
            let newObject = realm.create(T.self as! Object.Type, value: object, update: true) as! T
            completion(newObject)
        }
    }
    
    func save(object: Storable) throws {
        guard let realm = self.realm else {
            throw NSError()
        }
        
        try self.safeWrite {
            realm.add(object as! Object, update: true)
        }
    }
    
    func update(block: @escaping () -> Void) throws {
        try self.safeWrite {
            block()
        }
    }
    
    func delete(object: Storable) throws {
        guard let realm = self.realm else {
            throw NSError()
        }
        
        try self.safeWrite {
            realm.delete(object as! Object)
        }
    }
    
    func deleteAll<T: Storable>(_ model: T.Type) throws {
        guard let realm = self.realm else {
            throw NSError()
        }
        
        try self.safeWrite {
            let objects = realm.objects(model as! Object.Type)
            
            for object in objects {
                realm.delete(object)
            }
        }
    }
    
    func reset() throws {
        guard let realm = self.realm else {
            throw NSError()
        }
        
        try self.safeWrite {
            realm.deleteAll()
        }
    }
    
    func fetch<T: Storable>(_ model: T.Type, predicate: NSPredicate? = nil, sorted: Sorted? = nil, completion: (([T]) -> Void)) {
        var objects = self.realm?.objects(model as! Object.Type)
        
        if let predicate = predicate {
            objects = objects?.filter(predicate)
        }
        
        if let sorted = sorted {
            objects = objects?.sorted(byKeyPath: sorted.key, ascending: sorted.ascending)
        }
        
        var accumulate: [T] = [T]()
        for object in objects! {
            accumulate.append(object as! T)
        }
        
        completion(accumulate)
    }
    
    // MARK: Utils
    
    static fileprivate func getPath(_ identifier: String) -> URL {
        let realmPath = NSURL.fileURL(withPath: Realm.Configuration().fileURL!.absoluteString)
            .deletingLastPathComponent()
            .appendingPathComponent(identifier)
            .appendingPathExtension("realm")
        return realmPath
    }
}
