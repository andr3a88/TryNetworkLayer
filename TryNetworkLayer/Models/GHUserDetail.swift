//
//  GHUserDetail.swift
//
//  Created by Andrea Stevanato on 03/09/2017
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper
import Realm
import RealmSwift

public final class GHUserDetail: Object, Mappable {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let publicRepos = "public_repos"
        static let organizationsUrl = "organizations_url"
        static let reposUrl = "repos_url"
        static let starredUrl = "starred_url"
        static let type = "type"
        static let bio = "bio"
        static let gistsUrl = "gists_url"
        static let followersUrl = "followers_url"
        static let id = "id"
        static let blog = "blog"
        static let followers = "followers"
        static let following = "following"
        static let company = "company"
        static let url = "url"
        static let name = "name"
        static let updatedAt = "updated_at"
        static let publicGists = "public_gists"
        static let siteAdmin = "site_admin"
        static let gravatarId = "gravatar_id"
        static let htmlUrl = "html_url"
        static let avatarUrl = "avatar_url"
        static let login = "login"
        static let location = "location"
        static let createdAt = "created_at"
        static let subscriptionsUrl = "subscriptions_url"
        static let followingUrl = "following_url"
        static let receivedEventsUrl = "received_events_url"
        static let eventsUrl = "events_url"
        static let hireable = "hireable"
    }
    
    // MARK: Properties
    public var publicRepos: Int?
    public var organizationsUrl: String?
    public var reposUrl: String?
    public var starredUrl: String?
    public var type: String?
    public var bio: String?
    public var gistsUrl: String?
    public var followersUrl: String?
    public var id: Int?
    public var blog: String?
    public var followers: Int?
    public var following: Int?
    public var company: String?
    public var url: String?
    public var name: String?
    public var updatedAt: String?
    public var publicGists: Int?
    public var siteAdmin: Bool? = false
    public var gravatarId: String?
    public var htmlUrl: String?
    public var avatarUrl: String?
    public var login: String?
    public var location: String?
    public var createdAt: String?
    public var subscriptionsUrl: String?
    public var followingUrl: String?
    public var receivedEventsUrl: String?
    public var eventsUrl: String?
    public var hireable: Bool? = false
    
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
        publicRepos <- map[SerializationKeys.publicRepos]
        organizationsUrl <- map[SerializationKeys.organizationsUrl]
        reposUrl <- map[SerializationKeys.reposUrl]
        starredUrl <- map[SerializationKeys.starredUrl]
        type <- map[SerializationKeys.type]
        bio <- map[SerializationKeys.bio]
        gistsUrl <- map[SerializationKeys.gistsUrl]
        followersUrl <- map[SerializationKeys.followersUrl]
        id <- map[SerializationKeys.id]
        blog <- map[SerializationKeys.blog]
        followers <- map[SerializationKeys.followers]
        following <- map[SerializationKeys.following]
        company <- map[SerializationKeys.company]
        url <- map[SerializationKeys.url]
        name <- map[SerializationKeys.name]
        updatedAt <- map[SerializationKeys.updatedAt]
        publicGists <- map[SerializationKeys.publicGists]
        siteAdmin <- map[SerializationKeys.siteAdmin]
        gravatarId <- map[SerializationKeys.gravatarId]
        htmlUrl <- map[SerializationKeys.htmlUrl]
        avatarUrl <- map[SerializationKeys.avatarUrl]
        login <- map[SerializationKeys.login]
        location <- map[SerializationKeys.location]
        createdAt <- map[SerializationKeys.createdAt]
        subscriptionsUrl <- map[SerializationKeys.subscriptionsUrl]
        followingUrl <- map[SerializationKeys.followingUrl]
        receivedEventsUrl <- map[SerializationKeys.receivedEventsUrl]
        eventsUrl <- map[SerializationKeys.eventsUrl]
        hireable <- map[SerializationKeys.hireable]
    }
    
    /// Generates description of the object in the form of a NSDictionary.
    ///
    /// - returns: A Key value pair containing all valid values in the object.
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        if let value = publicRepos { dictionary[SerializationKeys.publicRepos] = value }
        if let value = organizationsUrl { dictionary[SerializationKeys.organizationsUrl] = value }
        if let value = reposUrl { dictionary[SerializationKeys.reposUrl] = value }
        if let value = starredUrl { dictionary[SerializationKeys.starredUrl] = value }
        if let value = type { dictionary[SerializationKeys.type] = value }
        if let value = bio { dictionary[SerializationKeys.bio] = value }
        if let value = gistsUrl { dictionary[SerializationKeys.gistsUrl] = value }
        if let value = followersUrl { dictionary[SerializationKeys.followersUrl] = value }
        if let value = id { dictionary[SerializationKeys.id] = value }
        if let value = blog { dictionary[SerializationKeys.blog] = value }
        if let value = followers { dictionary[SerializationKeys.followers] = value }
        if let value = following { dictionary[SerializationKeys.following] = value }
        if let value = company { dictionary[SerializationKeys.company] = value }
        if let value = url { dictionary[SerializationKeys.url] = value }
        if let value = name { dictionary[SerializationKeys.name] = value }
        if let value = updatedAt { dictionary[SerializationKeys.updatedAt] = value }
        if let value = publicGists { dictionary[SerializationKeys.publicGists] = value }
        dictionary[SerializationKeys.siteAdmin] = siteAdmin
        if let value = gravatarId { dictionary[SerializationKeys.gravatarId] = value }
        if let value = htmlUrl { dictionary[SerializationKeys.htmlUrl] = value }
        if let value = avatarUrl { dictionary[SerializationKeys.avatarUrl] = value }
        if let value = login { dictionary[SerializationKeys.login] = value }
        if let value = location { dictionary[SerializationKeys.location] = value }
        if let value = createdAt { dictionary[SerializationKeys.createdAt] = value }
        if let value = subscriptionsUrl { dictionary[SerializationKeys.subscriptionsUrl] = value }
        if let value = followingUrl { dictionary[SerializationKeys.followingUrl] = value }
        if let value = receivedEventsUrl { dictionary[SerializationKeys.receivedEventsUrl] = value }
        if let value = eventsUrl { dictionary[SerializationKeys.eventsUrl] = value }
        dictionary[SerializationKeys.hireable] = hireable
        return dictionary
    }
    
}
