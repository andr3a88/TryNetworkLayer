//
//  GHSearchResponse.swift
//
//  Created by Andrea Stevanato on 22/08/2017
//  Copyright (c) . All rights reserved.
//

import Foundation

public final class GHSearchResponse: Codable {

    enum CodingKeys: String, CodingKey {
        case incompleteResults = "incomplete_results"
        case totalCount = "total_count"
        case items = "items"
    }

    // MARK: Properties

    public var incompleteResults: Bool? = false
    public var totalCount: Int?
    public var items: [GHUser]?
}
