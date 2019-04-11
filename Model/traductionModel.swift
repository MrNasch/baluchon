//
//  traductionModel.swift
//  Baluchon
//
//  Created by Nasch on 25/03/2019.
//  Copyright © 2019 Nasch. All rights reserved.
//

import Foundation
struct Translation: Codable {
    
    let data: Translations
    
    struct Translations: Codable {
        
        let translations: [TranslatedText]
        
        struct TranslatedText: Codable {
            
            var translatedText: String
        }
    }
    
}
