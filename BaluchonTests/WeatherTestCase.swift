//
//  WeatherTestCase.swift
//  BaluchonTests
//
//  Created by Nasch on 10/04/2019.
//  Copyright © 2019 Nasch. All rights reserved.
//
@testable import Baluchon
import XCTest

class WeatherTestCase: XCTestCase {

    func testGivenGetWeather_WhenShouldGet_ThenCallbackError() {
    //Given
    let wheaterService = WeatherService(weatherSession: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
    //When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        wheaterService.getWeather { (success, weather) in
            // then
            XCTAssertFalse(success)
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    func testGivenGetWeather_WhenShouldGet_ThenCallbackNoData() {
        //Given
        let wheaterService = WeatherService(weatherSession: URLSessionFake(data: nil, response: nil, error: nil))
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        wheaterService.getWeather { (success, weather) in
            // then
            XCTAssertFalse(success)
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    func testGivenGetWeather_WhenShouldGet_ThenCallbackIncorrectResponse() {
        //Given
        let wheaterService = WeatherService(weatherSession: URLSessionFake(data: FakeResponseData.baluchonIncorrectData, response: FakeResponseData.responseOK, error: nil))
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        wheaterService.getWeather { (success, weather) in
            // then
            XCTAssertFalse(success)
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    func testGivenGetWeather_WhenShouldGet_ThenCallbackIncorrectData() {
        //Given
        let wheaterService = WeatherService(weatherSession: URLSessionFake(data: FakeResponseData.baluchonIncorrectData, response: FakeResponseData.responseKO, error: nil))
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        wheaterService.getWeather { (success, weather) in
            // then
            XCTAssertFalse(success)
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    func testGivenGetWeather_WhenShouldGet_ThenCallbackNoErrorAndCorrectData() {
        //Given
        let wheaterService = WeatherService(weatherSession: URLSessionFake(data: FakeResponseData.WheaterCorrectData, response: FakeResponseData.responseOK, error: nil))
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        wheaterService.getWeather { (success, weather) in
            // then
            let nameFirstCity = "New York"
            let descriptionFirstCity = "ciel dégagé"
            let tempFirstCity = -2.47
            let nameSecondCity = "Hannut"
            let descriptionSecondCity = "ciel dégagé"
            let tempSecondCity = 16.51
            
            XCTAssertTrue(success)
            XCTAssertNotNil(weather)
            XCTAssertEqual(nameFirstCity, weather!.list[1].name)
            XCTAssertEqual(descriptionFirstCity, weather!.list[1].weather[0].description)
            XCTAssertEqual(tempFirstCity, weather!.list[1].main.temp)
            XCTAssertEqual(nameSecondCity, weather!.list[0].name)
            XCTAssertEqual(descriptionSecondCity, weather!.list[0].weather[0].description)
            XCTAssertEqual(tempSecondCity, weather!.list[0].main.temp)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
}
