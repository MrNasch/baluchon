//
//  TraductionService.swift
//  Baluchon
//
//  Created by Nasch on 28/03/2019.
//  Copyright © 2019 Nasch. All rights reserved.
//

import Foundation

class TraductionService {
    // shared instane
    static var shared = TraductionService()
    private init() {}
   
    //create session
    private var traductionSession = URLSession(configuration: .default)
    
    init(traductionSession: URLSession) {
        self.traductionSession = traductionSession
    }
    private var task: URLSessionDataTask?
    
    // create func that get traduction from cloud
    func PostTraduction(textToTranslate: String, target: String, source: String, callback: @escaping (Bool, Translation?) -> Void) {
        let request = createTranslateRequest(textToTranslate, target: target, source: source)
        // cancel
        task?.cancel()
        // Task creation
        task = traductionSession.dataTask(with: request) { (data, response, error) in
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
                guard let translation = try? decoder.decode(Translation.self, from: data) else {
                    callback(false, nil)
                    return
                }
                // succes
                callback(true, translation)
            }
        }
        task?.resume()
    }
    private func createTranslateRequest(_ textToTranslate: String, target: String, source: String) -> URLRequest {
        let url = URL(string: "https://translation.googleapis.com/language/translate/v2")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let key = ""
        let q = textToTranslate
        let format = "text"
        let body = "key=\(key)&target=\(target)&q=\(q)&format=\(format)&source=\(source)"
        request.httpBody = body.data(using: .utf8)
        
        return request
    }
}
