//
//  MockSearchResponse.swift
//  TryNetworkLayerTests
//
//  Created by Andrea Stevanato on 05/03/2020.
//  Copyright © 2020 Andrea Stevanato. All rights reserved.
//

import Foundation

struct MockSearchResponse {
    static let incompleteResults = false
    static let totalCount = 800
    static let items = [MockGHUser(id: 1).JSON(), MockGHUser(id: 2).JSON()]

    func JSON() -> [String: Any] {
        return ["incomplete_results": MockSearchResponse.incompleteResults,
                "total_count": MockSearchResponse.totalCount,
                "items": MockSearchResponse.items]
    }
}

