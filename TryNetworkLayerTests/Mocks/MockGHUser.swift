//
//  MockGHUser.swift
//  TryNetworkLayerTests
//
//  Created by Andrea Stevanato on 05/03/2020.
//  Copyright © 2020 Andrea Stevanato. All rights reserved.
//

import Foundation

struct MockGHUser {
    static let organizationsUrl = "url"
    static let score = 1
    static let reposUrl = "url"
    static let htmlUrl = "url"
    static let gravatarId = "id"
    static let avatarUrl = "url"
    static let type = "user"
    static let login = "url"
    static let followersUrl = "url"
    static let subscriptionsUrl = "url"
    static let receivedEventsUrl = "url"
    static let url = "url"

    var id = 123456

    init(id: Int) {
        self.id = id
    }

    func JSON() -> [String: Any] {
        return ["organizations_url": MockGHUser.organizationsUrl,
                "score": MockGHUser.score,
                "repos_url": MockGHUser.reposUrl,
                "html_url": MockGHUser.htmlUrl,
                "gravatar_id": MockGHUser.gravatarId,
                "avatar_url": MockGHUser.avatarUrl,
                "type": MockGHUser.type,
                "login": MockGHUser.login,
                "followers_url": MockGHUser.followersUrl,
                "id": id,
                "subscriptions_url": MockGHUser.subscriptionsUrl,
                "received_events_url": MockGHUser.receivedEventsUrl,
                "url": MockGHUser.url]
    }
}
