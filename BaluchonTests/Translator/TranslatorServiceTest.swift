//
//  TranslatorServiceTest.swift
//  BaluchonTests
//
//  Created by Square on 09/12/2021.
//

import XCTest
@testable import Baluchon

class TranslatorServiceTest: XCTestCase {
    

    let sut: TranslatorService = .init()
    var target: String = "EN"
    // MARK: - Tests

//    func testGetRatesShould() {
//        sut.getData(text: "Bonjour, je m'appelle Michel", target: "EN"){ result in
//            switch result {
//            case .failure(let error):
//            XCTAssertEqual(error, .noData)
//            case .success:
//                XCTFail("")
//            }
//        }
//    }
    
    private let sessionConfiguration: URLSessionConfiguration = {
        let sessionConfiguration = URLSessionConfiguration.ephemeral
        sessionConfiguration.protocolClasses = [URLProtocolFake.self]
        return sessionConfiguration
    }()
    
    // MARK: - Tests

    func tests_getData_WhenFakeSessionWithErrorIsPassed_ThenShouldReturnAnError() {
        URLProtocolFake.fakeURLs = [FakeResponseTranslatorData.url: (nil, nil, FakeResponseTranslatorData.error)]
        let fakeSession = URLSession(configuration: sessionConfiguration)
        let sut: TranslatorService = .init(session: fakeSession)

        let expectation = XCTestExpectation(description: "Waiting...")
        sut.getData(text: "Bonjour", target: target) { result in
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
        URLProtocolFake.fakeURLs = [FakeResponseTranslatorData.url: (FakeResponseTranslatorData.correctData, FakeResponseTranslatorData.responseKO, nil)]
        let fakeSession = URLSession(configuration: sessionConfiguration)
        let sut: TranslatorService = .init(session: fakeSession)

        let expectation = XCTestExpectation(description: "Waiting...")
        sut.getData(text: "Bonjour", target: target) { result in
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
        URLProtocolFake.fakeURLs = [FakeResponseTranslatorData.url: (FakeResponseTranslatorData.incorrectData, FakeResponseTranslatorData.responseOK, nil)]
        let fakeSession = URLSession(configuration: sessionConfiguration)
        let sut: TranslatorService = .init(session: fakeSession)

        let expectation = XCTestExpectation(description: "Waiting...")
        sut.getData(text: "Bonjour", target: target) { result in
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
        URLProtocolFake.fakeURLs = [FakeResponseTranslatorData.url: (FakeResponseTranslatorData.correctData, FakeResponseTranslatorData.responseOK, nil)]
        let fakeSession = URLSession(configuration: sessionConfiguration)
        let sut: TranslatorService = .init(session: fakeSession)

        let expectation = XCTestExpectation(description: "Waiting...")
        sut.getData(text: "Bonjour", target: target) { result in
            guard case .success(let translatedText) = result else {
                XCTFail("Test failed: \(#function)")
                return
            }
            
            let text = "Hello my name is michel"
            
            XCTAssertTrue(text == translatedText.translations[0].text)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
}
