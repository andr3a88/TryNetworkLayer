//
//  GHSearchResponse.swift
//
//  Created by Andrea Stevanato on 22/08/2017
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper

public final class GHSearchResponse: Mappable {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let incompleteResults = "incomplete_results"
    static let totalCount = "total_count"
    static let items = "items"
  }

  // MARK: Properties
  public var incompleteResults: Bool? = false
  public var totalCount: Int?
  public var items: [GHUser]?

  // MARK: ObjectMapper Initializers
  /// Map a JSON object to this class using ObjectMapper.
  ///
  /// - parameter map: A mapping from ObjectMapper.
  public required init?(map: Map) {

  }

  /// Map a JSON object to this class using ObjectMapper.
  ///
  /// - parameter map: A mapping from ObjectMapper.
  public func mapping(map: Map) {
    incompleteResults <- map[SerializationKeys.incompleteResults]
    totalCount <- map[SerializationKeys.totalCount]
    items <- map[SerializationKeys.items]
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    dictionary[SerializationKeys.incompleteResults] = incompleteResults
    if let value = totalCount { dictionary[SerializationKeys.totalCount] = value }
    if let value = items { dictionary[SerializationKeys.items] = value.map { $0.dictionaryRepresentation() } }
    return dictionary
  }

}
