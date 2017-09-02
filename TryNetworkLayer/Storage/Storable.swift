//
//  Storable.swift
//  TryNetworkLayer
//
//  Created by Andrea Stevanato on 02/09/2017.
//  Copyright © 2017 Ennova Research Srl. All rights reserved.
//

import Foundation
import RealmSwift

/// Storable object
public protocol Storable {
}

extension Object: Storable {
}
