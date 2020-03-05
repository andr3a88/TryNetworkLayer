//
//  GHItems.swift
//
//  Created by Andrea Stevanato on 22/08/2017
//  Copyright (c) . All rights reserved.
//

import Foundation
import Realm
import RealmSwift

public final class GHUser: Object, Codable {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    
    enum CodingKeys: String, CodingKey {
        case organizationsUrl = "organizations_url"
        case score = "score"
        case reposUrl = "repos_url"
        case htmlUrl = "html_url"
        case gravatarId = "gravatar_id"
        case avatarUrl = "avatar_url"
        case type = "type"
        case login = "login"
        case followersUrl = "followers_url"
        case id = "id"
        case subscriptionsUrl = "subscriptions_url"
        case receivedEventsUrl = "received_events_url"
        case url = "url"
    }
    
    // MARK: Properties

    @objc dynamic public var organizationsUrl: String?
    @objc dynamic public var score: Float = 0
    @objc dynamic public var reposUrl: String?
    @objc dynamic public var htmlUrl: String?
    @objc dynamic public var gravatarId: String?
    @objc dynamic public var avatarUrl: String?
    @objc dynamic public var type: String?
    @objc dynamic public var login: String = ""
    @objc dynamic public var followersUrl: String?
    @objc dynamic public var id: Int = 0
    @objc dynamic public var subscriptionsUrl: String?
    @objc dynamic public var receivedEventsUrl: String?
    @objc dynamic public var url: String?
    
    // MARK: Primary Key
    
    override public static func primaryKey() -> String? {
        "id"
    }
    
    // MARK: Init
    
    required public init() {
        super.init()
    }
}
