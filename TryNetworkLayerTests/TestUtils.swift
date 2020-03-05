//
//  TestUtils.swift
//  TryNetworkLayerTests
//
//  Created by Andrea Stevanato on 04/03/2020.
//  Copyright © 2020 Andrea Stevanato. All rights reserved.
//

import Foundation
@testable import TryNetworkLayer

struct TestUtils {
    struct Env {
        static let Local = Environment("Local", host: "http://localhost:3900")
        static let GitHub = Environment("Github", host: "https://api.github.com")

        static let `default` = TestUtils.Env.GitHub
    }
}


