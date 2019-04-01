//
//  WeatherModel.swift
//  Baluchon
//
//  Created by Nasch on 25/03/2019.
//  Copyright © 2019 Nasch. All rights reserved.
//

import Foundation

struct WeatherCity: Codable {
    let list: [City]
    
    struct City: Codable {
        let name: String
        let main: Main
        let weather: [Weather]
        
        struct Weather: Codable {
            var description: String
        }
        struct Main: Codable {
            var temp: Double
        }
    }
}
