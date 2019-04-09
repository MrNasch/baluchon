//
//  traductionModel.swift
//  Baluchon
//
//  Created by Nasch on 25/03/2019.
//  Copyright © 2019 Nasch. All rights reserved.
//

import Foundation
struct Traduction: Codable {
    
    let data: Traductions
    
    struct Traductions: Codable {
        var translatedText: String
    }
}
