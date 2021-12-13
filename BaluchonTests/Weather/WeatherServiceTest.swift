//
//  WeatherServiceTest.swift
//  BaluchonTests
//
//  Created by Square on 08/12/2021.
//

//
//  TranslatorServiceTest.swift
//  BaluchonTests
//
//  Created by Square on 09/12/2021.
//

import XCTest
@testable import Baluchon

class WeatherServiceTest: XCTestCase {
    

    let sut: WeatherService = .init()
    // MARK: - Tests

    private let sessionConfiguration: URLSessionConfiguration = {
        let sessionConfiguration = URLSessionConfiguration.ephemeral
        sessionConfiguration.protocolClasses = [URLProtocolFake.self]
        return sessionConfiguration
    }()
    
    // MARK: - Tests

    func tests_getData_WhenFakeSessionWithErrorIsPassed_ThenShouldReturnAnError() {
        URLProtocolFake.fakeURLs = [FakeResponseWeatherData.url: (nil, nil, FakeResponseWeatherData.error)]
        let fakeSession = URLSession(configuration: sessionConfiguration)
        let sut: WeatherService = .init(session: fakeSession)

        let expectation = XCTestExpectation(description: "Waiting...")
        sut.getData{ result in
            guard case .failure(let error) = result else {
                XCTFail("Test failed: \(#function)")
                return
            }
            XCTAssertTrue(error == .noData)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func tests_getData_WhenFakeSessionWithRatesCorrectDataAndInvalidResponseArePassed_ThenShouldReturnAnError() {
        URLProtocolFake.fakeURLs = [FakeResponseWeatherData.url: (FakeResponseWeatherData.correctData, FakeResponseWeatherData.responseKO, nil)]
        let fakeSession = URLSession(configuration: sessionConfiguration)
        let sut: WeatherService = .init(session: fakeSession)

        let expectation = XCTestExpectation(description: "Waiting...")
        sut.getData{ result in
            guard case .failure(let error) = result else {
                XCTFail("Test failed: \(#function)")
                return
            }
            XCTAssertTrue(error == .invalidResponse)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func tests_getData_WhenFakeSessionWithRatesIncorrectDataAndValidResponseArePassed_ThenShouldReturnAnError() {
        URLProtocolFake.fakeURLs = [FakeResponseWeatherData.url: (FakeResponseWeatherData.incorrectData, FakeResponseWeatherData.responseOK, nil)]
        let fakeSession = URLSession(configuration: sessionConfiguration)
        let sut: WeatherService = .init(session: fakeSession)

        let expectation = XCTestExpectation(description: "Waiting...")
        sut.getData{ result in
            guard case .failure(let error) = result else {
                XCTFail("Test failed: \(#function)")
                return
            }
            XCTAssertTrue(error == .undecodableData)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func tests_getData_WhenFakeSessionWithCorrectDataAndValidResponseArePassed_ThenShouldACorrectConvertion() {
        URLProtocolFake.fakeURLs = [FakeResponseWeatherData.url: (FakeResponseWeatherData.correctData, FakeResponseWeatherData.responseOK, nil)]
        let fakeSession = URLSession(configuration: sessionConfiguration)
        let sut: WeatherService = .init(session: fakeSession)

        let expectation = XCTestExpectation(description: "Waiting...")
        sut.getData{ result in
            guard case .success(let weatherOK) = result else {
                XCTFail("Test failed: \(#function)")
                return
            }
            
            let cityNY = OpenWeatherMap.self
            
            XCTAssertTrue(cityNY == weatherOK.list[0].weather[0].weatherDescription)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
}
