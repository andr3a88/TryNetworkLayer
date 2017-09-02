//
//  GHItems.swift
//
//  Created by Andrea Stevanato on 22/08/2017
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper
import Realm
import RealmSwift

public final class GHUser: Object, Mappable {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let organizationsUrl = "organizations_url"
        static let score = "score"
        static let reposUrl = "repos_url"
        static let htmlUrl = "html_url"
        static let gravatarId = "gravatar_id"
        static let avatarUrl = "avatar_url"
        static let type = "type"
        static let login = "login"
        static let followersUrl = "followers_url"
        static let id = "id"
        static let subscriptionsUrl = "subscriptions_url"
        static let receivedEventsUrl = "received_events_url"
        static let url = "url"
    }
    
    // MARK: Properties
    dynamic public var organizationsUrl: String?
    dynamic public var score: Int = 0
    dynamic public var reposUrl: String?
    dynamic public var htmlUrl: String?
    dynamic public var gravatarId: String?
    dynamic public var avatarUrl: String?
    dynamic public var type: String?
    dynamic public var login: String?
    dynamic public var followersUrl: String?
    dynamic public var id: Int = 0
    dynamic public var subscriptionsUrl: String?
    dynamic public var receivedEventsUrl: String?
    dynamic public var url: String?
    
    // MARK: Primary Key
    
    override public static func primaryKey() -> String? {
        return "id"
    }
    
    // MARK: Init
    
    required public init() {
        super.init()
    }
    
    required public init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
    
    required public init(value: Any, schema: RLMSchema) {
        fatalError("init(value:schema:) has not been implemented")
    }
    
    // MARK: ObjectMapper Initializers
    /// Map a JSON object to this class using ObjectMapper.
    ///
    /// - parameter map: A mapping from ObjectMapper.
    public required init?(map: Map) {
        super.init()
    }
    
    /// Map a JSON object to this class using ObjectMapper.
    ///
    /// - parameter map: A mapping from ObjectMapper.
    public func mapping(map: Map) {
        organizationsUrl <- map[SerializationKeys.organizationsUrl]
        score <- map[SerializationKeys.score]
        reposUrl <- map[SerializationKeys.reposUrl]
        htmlUrl <- map[SerializationKeys.htmlUrl]
        gravatarId <- map[SerializationKeys.gravatarId]
        avatarUrl <- map[SerializationKeys.avatarUrl]
        type <- map[SerializationKeys.type]
        login <- map[SerializationKeys.login]
        followersUrl <- map[SerializationKeys.followersUrl]
        id <- map[SerializationKeys.id]
        subscriptionsUrl <- map[SerializationKeys.subscriptionsUrl]
        receivedEventsUrl <- map[SerializationKeys.receivedEventsUrl]
        url <- map[SerializationKeys.url]
    }
    
    /// Generates description of the object in the form of a NSDictionary.
    ///
    /// - returns: A Key value pair containing all valid values in the object.
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        if let value = organizationsUrl { dictionary[SerializationKeys.organizationsUrl] = value }
        dictionary[SerializationKeys.score] = score
        if let value = reposUrl { dictionary[SerializationKeys.reposUrl] = value }
        if let value = htmlUrl { dictionary[SerializationKeys.htmlUrl] = value }
        if let value = gravatarId { dictionary[SerializationKeys.gravatarId] = value }
        if let value = avatarUrl { dictionary[SerializationKeys.avatarUrl] = value }
        if let value = type { dictionary[SerializationKeys.type] = value }
        if let value = login { dictionary[SerializationKeys.login] = value }
        if let value = followersUrl { dictionary[SerializationKeys.followersUrl] = value }
        dictionary[SerializationKeys.id] = id
        if let value = subscriptionsUrl { dictionary[SerializationKeys.subscriptionsUrl] = value }
        if let value = receivedEventsUrl { dictionary[SerializationKeys.receivedEventsUrl] = value }
        if let value = url { dictionary[SerializationKeys.url] = value }
        return dictionary
    }
    
}
