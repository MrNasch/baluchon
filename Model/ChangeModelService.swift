//
//  Model.swift
//  Baluchon
//
//  Created by Nasch on 21/03/2019.
//  Copyright © 2019 Nasch. All rights reserved.
//

import Foundation

class ChangeService {
    // chared instance
    static var shared = ChangeService()
    private init() {}
    // Url of the API
    private let changeUrl = URL(string: "http://data.fixer.io/api/latest?access_key=c29967643b875302f204ce0268dd4343")!
    
    
    // Create Session
    private var changeSession = URLSession(configuration: .default)
    
    init(changeSession: URLSession) {
        self.changeSession = changeSession
    }
    private var task: URLSessionDataTask?
    
    // create func that get change rates from Fixer.io
    func getChange(callback: @escaping (Bool, Change?) -> Void?) {
        // cancel
        task?.cancel()
        // Task creation
        task = changeSession.dataTask(with: changeUrl) { (data, response, error) in
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
                guard let changeRate = try? decoder.decode(Change.self, from: data) else {
                        callback(false, nil)
                        return
                }
                // succes
                callback(true, changeRate)
            }
        }
        task?.resume()
    }
}
