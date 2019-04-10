//
//  FakeResponseData.swift
//  BaluchonTests
//
//  Created by Nasch on 10/04/2019.
//  Copyright © 2019 Nasch. All rights reserved.
//

import Foundation

class FakeResponseData {
    // error response
    let responseOK = HTTPURLResponse(url: URL(string: "http://openclassrooms.com")!,
                                     statusCode: 200, httpVersion: nil, headerFields: nil)!
    let responseOKO = HTTPURLResponse(url: URL(string: "http://openclassrooms.com")!,
                                     statusCode: 500, httpVersion: nil, headerFields: nil)!
    
    // error
    class BaluchonError: Error { }
        let error = BaluchonError()
    
    // wheater fake data ok
    var WheaterCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "wheaterCity", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    // change fake data ok
    var ChangeCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "change", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    // traduction fake data ok
    var TraductionCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "traduction", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    // incorrect data
    let baluchonIncorrectData = "erreur".data(using: .utf8)
}
