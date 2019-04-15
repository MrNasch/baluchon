//
//  ChangeTestCase.swift
//  BaluchonTests
//
//  Created by Nasch on 10/04/2019.
//  Copyright © 2019 Nasch. All rights reserved.
//
@testable import Baluchon
import XCTest

class ChangeTestCase: XCTestCase {

    func testGivenGetChange_WhenShouldGet_ThenCallbackError() {
        //Given
        let changeService = ChangeService(changeSession: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        changeService.getChange { (success, change) in
            // then
            XCTAssertFalse(success)
            XCTAssertNil(change)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    func testGivenGetChange_WhenShouldGet_ThenCallbackNoData() {
        //Given
        let changeService = ChangeService(changeSession: URLSessionFake(data: nil, response: nil, error: nil))
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        changeService.getChange { (success, change) in
            // then
            XCTAssertFalse(success)
            XCTAssertNil(change)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    func testGivenGetChange_WhenShouldGet_ThenCallbackIncorrectResponse() {
        //Given
        let changeService = ChangeService(changeSession: URLSessionFake(data: FakeResponseData.baluchonIncorrectData, response: FakeResponseData.responseOK, error: nil))
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        changeService.getChange { (success, change) in
            // then
            XCTAssertFalse(success)
            XCTAssertNil(change)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    func testGivenGetChange_WhenShouldGet_ThenCallbackIncorrectData() {
        //Given
        let changeService = ChangeService(changeSession: URLSessionFake(data: FakeResponseData.baluchonIncorrectData, response: FakeResponseData.responseKO, error: nil))
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        changeService.getChange { (success, change) in
            // then
            XCTAssertFalse(success)
            XCTAssertNil(change)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    func testGivenGetChange_WhenShouldGet_ThenCallbackNoErrorAndCorrectData() {
        //Given
        let changeService = ChangeService(changeSession: URLSessionFake(data: FakeResponseData.ChangeCorrectData, response: FakeResponseData.responseOK, error: nil))
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        changeService.getChange { (success, change) in
            // then
            let date = "2019-04-01"
            let base = "EUR"
            let rates = ["EUR": 1,
                         "USD": 1.122353]
            XCTAssertTrue(success)
            XCTAssertNotNil(change)
            XCTAssertEqual(date, change!.date)
            XCTAssertEqual(base, change!.base)
            XCTAssertEqual(rates, change!.rates)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
}
