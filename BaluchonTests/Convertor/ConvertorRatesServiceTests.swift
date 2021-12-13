//
//  ConvertorTests.swift
//  BaluchonTests
//
//  Created by Square on 07/12/2021.
//

import XCTest

@testable import Baluchon

class ConvertorRatesServiceTests: XCTestCase {

    // MARK: - Properties

    private let sut: ConvertorRatesService = .init()

    // MARK: - Tests

    private let sessionConfiguration: URLSessionConfiguration = {
        let sessionConfiguration = URLSessionConfiguration.ephemeral
        sessionConfiguration.protocolClasses = [URLProtocolFake.self]
        return sessionConfiguration
    }()
    
    // MARK: - Tests

    func tests_getData_WhenFakeSessionWithErrorIsPassed_ThenShouldReturnAnError() {
        URLProtocolFake.fakeURLs = [FakeResponseConvertorData.url: (nil, nil, FakeResponseConvertorData.error)]
        let fakeSession = URLSession(configuration: sessionConfiguration)
        let sut: ConvertorRatesService = .init(session: fakeSession)

        let expectation = XCTestExpectation(description: "Waiting...")
        sut.getData { result in
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
        URLProtocolFake.fakeURLs = [FakeResponseConvertorData.url: (FakeResponseConvertorData.correctData, FakeResponseConvertorData.responseKO, nil)]
        let fakeSession = URLSession(configuration: sessionConfiguration)
        let sut: ConvertorRatesService = .init(session: fakeSession)

        let expectation = XCTestExpectation(description: "Waiting...")
        sut.getData { result in
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
        URLProtocolFake.fakeURLs = [FakeResponseConvertorData.url: (FakeResponseConvertorData.incorrectData, FakeResponseConvertorData.responseOK, nil)]
        let fakeSession = URLSession(configuration: sessionConfiguration)
        let sut: ConvertorRatesService = .init(session: fakeSession)

        let expectation = XCTestExpectation(description: "Waiting...")
        sut.getData { result in
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
        URLProtocolFake.fakeURLs = [FakeResponseConvertorData.url: (FakeResponseConvertorData.correctData, FakeResponseConvertorData.responseOK, nil)]
        let fakeSession = URLSession(configuration: sessionConfiguration)
        let sut: ConvertorRatesService = .init(session: fakeSession)

        let expectation = XCTestExpectation(description: "Waiting...")
        sut.getData { result in
            guard case .success(let rates) = result else {
                XCTFail("Test failed: \(#function)")
                return
            }
            let rate = rates.rates["USD"]
            
            XCTAssertTrue(rate == rates.rates["USD"])
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
}
