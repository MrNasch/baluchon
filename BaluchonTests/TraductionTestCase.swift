//
//  TraductionTestCase.swift
//  BaluchonTests
//
//  Created by Nasch on 10/04/2019.
//  Copyright © 2019 Nasch. All rights reserved.
//
@testable import Baluchon
import XCTest

class TraductionTestCase: XCTestCase {

    func testGivenGetChange_WhenShouldGet_ThenCallbackError() {
        //Given
        let traductionService = TraductionService(traductionSession: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        traductionService.PostTraduction(textToTranslate: "Voici un test", target: "en", source: "fr") { (success, translation) in
            // then
            XCTAssertFalse(success)
            XCTAssertNil(translation)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    func testGivenGetChange_WhenShouldGet_ThenCallbackNoData() {
        //Given
        let traductionService = TraductionService(traductionSession: URLSessionFake(data: nil, response: nil, error: nil))
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        traductionService.PostTraduction(textToTranslate: "Voici un test", target: "en", source: "fr") { (success, translation) in
            // then
            XCTAssertFalse(success)
            XCTAssertNil(translation)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    func testGivenGetChange_WhenShouldGet_ThenCallbackIncorrectResponse() {
        //Given
        let traductionService = TraductionService(traductionSession: URLSessionFake(data: FakeResponseData.baluchonIncorrectData, response: FakeResponseData.responseOK, error: nil))
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        traductionService.PostTraduction(textToTranslate: "Voici un test", target: "en", source: "fr") { (success, translation) in
            // then
            XCTAssertFalse(success)
            XCTAssertNil(translation)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    func testGivenGetChange_WhenShouldGet_ThenCallbackIncorrectData() {
        //Given
        let traductionService = TraductionService(traductionSession: URLSessionFake(data: FakeResponseData.baluchonIncorrectData, response: FakeResponseData.responseKO, error: nil))
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        traductionService.PostTraduction(textToTranslate: "Voici un test", target: "en", source: "fr") { (success, translation) in
            // then
            XCTAssertFalse(success)
            XCTAssertNil(translation)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    func testGivenGetChange_WhenShouldGet_ThenCallbackNoErrorAndCorrectData() {
        //Given
        let traductionService = TraductionService(traductionSession: URLSessionFake(data: FakeResponseData.TraductionCorrectData, response: FakeResponseData.responseOK, error: nil))
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        traductionService.PostTraduction(textToTranslate: "Voici un test", target: "en", source: "fr") { (success, translation) in
            // then
            let translatedText = "here is a test"
            XCTAssertTrue(success)
            XCTAssertNotNil(translation)
            XCTAssertEqual(translatedText, translation!.data.translations[0].translatedText)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
}
