//
//  WeatherService.swift
//  Baluchon
//
//  Created by Nasch on 28/03/2019.
//  Copyright © 2019 Nasch. All rights reserved.
//

import Foundation
class WeatherService {
    //Instance
    static var shared = WeatherService()
    private init() {}
    
    // API URL
    private let weatherUrl = URL(string: "http://api.openweathermap.org/data/2.5/group?id=2796584,5128638&APPID=3066b37bb5e88c5fff0962e868a87a39&units=metric&lang=fr")!
    
    //create session fake
    private var weatherSession = URLSession(configuration: .default)
    
    init(weatherSession: URLSession) {
        self.weatherSession = weatherSession
    }
    // task
    private var task: URLSessionDataTask?
    
    //create func that get weather from openweathermap
    func getWeather(callback: @escaping (Bool, WeatherCity?) ->Void) {
        //cancel
        task?.cancel()
        //task creation
        task = weatherSession.dataTask(with: weatherUrl) { (data, response, error) in
            DispatchQueue.main.async {
                // Check for data
                guard let data = data, error == nil else {
                    callback(false, nil)
                    return
                }
                //check response
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false, nil)
                    return
                }
                // Check decoder
                let decoder = JSONDecoder()
                guard let weather = try? decoder.decode(WeatherCity.self, from: data) else {
                    callback(false, nil)
                    return
                }
                // succes
                callback(true, weather)
            }
        }
        task?.resume()
    }
}


