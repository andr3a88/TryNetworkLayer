//
//  GHUsers.swift
//
//  Created by Andrea on 22/08/2017
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper

public final class GHUser: Mappable {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let organizationsUrl = "organizations_url"
    static let reposUrl = "repos_url"
    static let htmlUrl = "html_url"
    static let siteAdmin = "site_admin"
    static let gravatarId = "gravatar_id"
    static let starredUrl = "starred_url"
    static let avatarUrl = "avatar_url"
    static let type = "type"
    static let gistsUrl = "gists_url"
    static let login = "login"
    static let followersUrl = "followers_url"
    static let id = "id"
    static let subscriptionsUrl = "subscriptions_url"
    static let followingUrl = "following_url"
    static let receivedEventsUrl = "received_events_url"
    static let eventsUrl = "events_url"
    static let url = "url"
  }

  // MARK: Properties
  public var organizationsUrl: String?
  public var reposUrl: String?
  public var htmlUrl: String?
  public var siteAdmin: Bool? = false
  public var gravatarId: String?
  public var starredUrl: String?
  public var avatarUrl: String?
  public var type: String?
  public var gistsUrl: String?
  public var login: String?
  public var followersUrl: String?
  public var id: Int?
  public var subscriptionsUrl: String?
  public var followingUrl: String?
  public var receivedEventsUrl: String?
  public var eventsUrl: String?
  public var url: String?

  // MARK: ObjectMapper Initializers
  /// Map a JSON object to this class using ObjectMapper.
  ///
  /// - parameter map: A mapping from ObjectMapper.
  public required init?(map: Map){

  }

  /// Map a JSON object to this class using ObjectMapper.
  ///
  /// - parameter map: A mapping from ObjectMapper.
  public func mapping(map: Map) {
    organizationsUrl <- map[SerializationKeys.organizationsUrl]
    reposUrl <- map[SerializationKeys.reposUrl]
    htmlUrl <- map[SerializationKeys.htmlUrl]
    siteAdmin <- map[SerializationKeys.siteAdmin]
    gravatarId <- map[SerializationKeys.gravatarId]
    starredUrl <- map[SerializationKeys.starredUrl]
    avatarUrl <- map[SerializationKeys.avatarUrl]
    type <- map[SerializationKeys.type]
    gistsUrl <- map[SerializationKeys.gistsUrl]
    login <- map[SerializationKeys.login]
    followersUrl <- map[SerializationKeys.followersUrl]
    id <- map[SerializationKeys.id]
    subscriptionsUrl <- map[SerializationKeys.subscriptionsUrl]
    followingUrl <- map[SerializationKeys.followingUrl]
    receivedEventsUrl <- map[SerializationKeys.receivedEventsUrl]
    eventsUrl <- map[SerializationKeys.eventsUrl]
    url <- map[SerializationKeys.url]
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = organizationsUrl { dictionary[SerializationKeys.organizationsUrl] = value }
    if let value = reposUrl { dictionary[SerializationKeys.reposUrl] = value }
    if let value = htmlUrl { dictionary[SerializationKeys.htmlUrl] = value }
    dictionary[SerializationKeys.siteAdmin] = siteAdmin
    if let value = gravatarId { dictionary[SerializationKeys.gravatarId] = value }
    if let value = starredUrl { dictionary[SerializationKeys.starredUrl] = value }
    if let value = avatarUrl { dictionary[SerializationKeys.avatarUrl] = value }
    if let value = type { dictionary[SerializationKeys.type] = value }
    if let value = gistsUrl { dictionary[SerializationKeys.gistsUrl] = value }
    if let value = login { dictionary[SerializationKeys.login] = value }
    if let value = followersUrl { dictionary[SerializationKeys.followersUrl] = value }
    if let value = id { dictionary[SerializationKeys.id] = value }
    if let value = subscriptionsUrl { dictionary[SerializationKeys.subscriptionsUrl] = value }
    if let value = followingUrl { dictionary[SerializationKeys.followingUrl] = value }
    if let value = receivedEventsUrl { dictionary[SerializationKeys.receivedEventsUrl] = value }
    if let value = eventsUrl { dictionary[SerializationKeys.eventsUrl] = value }
    if let value = url { dictionary[SerializationKeys.url] = value }
    return dictionary
  }

}
