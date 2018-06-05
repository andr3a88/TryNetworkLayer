//
//  GHUserDetail.swift
//
//  Created by Andrea Stevanato on 03/09/2017
//  Copyright (c) . All rights reserved.
//

import Foundation
import Realm
import RealmSwift

public final class GHUserDetail: Object, Codable {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    enum CodingKeys: String, CodingKey {
        case publicRepos = "public_repos"
        case organizationsUrl = "organizations_url"
        case reposUrl = "repos_url"
        case starredUrl = "starred_url"
        case type = "type"
        case bio = "bio"
        case gistsUrl = "gists_url"
        case followersUrl = "followers_url"
        case id = "id"
        case blog = "blog"
        case followers = "followers"
        case following = "following"
        case company = "company"
        case url = "url"
        case name = "name"
        case updatedAt = "updated_at"
        case publicGists = "public_gists"
        case siteAdmin = "site_admin"
        case gravatarId = "gravatar_id"
        case htmlUrl = "html_url"
        case avatarUrl = "avatar_url"
        case login = "login"
        case location = "location"
        case createdAt = "created_at"
        case subscriptionsUrl = "subscriptions_url"
        case followingUrl = "following_url"
        case receivedEventsUrl = "received_events_url"
        case eventsUrl = "events_url"
    }
    
    // MARK: Properties
    @objc dynamic public var publicRepos: Int = 0
    @objc dynamic public var organizationsUrl: String?
    @objc dynamic public var reposUrl: String?
    @objc dynamic public var starredUrl: String?
    @objc dynamic public var type: String?
    @objc dynamic public var bio: String?
    @objc dynamic public var gistsUrl: String?
    @objc dynamic public var followersUrl: String?
    @objc dynamic public var id: Int = 0
    @objc dynamic public var blog: String?
    @objc dynamic public var followers: Int = 0
    @objc dynamic public var following: Int = 0
    @objc dynamic public var company: String?
    @objc dynamic public var url: String?
    @objc dynamic public var name: String?
    @objc dynamic public var updatedAt: String?
    @objc dynamic public var publicGists: Int = 0
    @objc dynamic public var siteAdmin: Bool = false
    @objc dynamic public var gravatarId: String?
    @objc dynamic public var htmlUrl: String?
    @objc dynamic public var avatarUrl: String?
    @objc dynamic public var login: String?
    @objc dynamic public var location: String?
    @objc dynamic public var createdAt: String?
    @objc dynamic public var subscriptionsUrl: String?
    @objc dynamic public var followingUrl: String?
    @objc dynamic public var receivedEventsUrl: String?
    @objc dynamic public var eventsUrl: String?
    
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
}
