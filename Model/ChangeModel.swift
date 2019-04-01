//
//  ChangeModel.swift
//  Baluchon
//
//  Created by Nasch on 28/03/2019.
//  Copyright © 2019 Nasch. All rights reserved.
//

import Foundation
struct Change: Codable {
    var success: Bool
    var timestamp: Int
    var base: String
    var date: String
    var rates: [String: Double]
}
