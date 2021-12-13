//
//  FakeResponseWeatherData.swift
//  BaluchonTests
//
//  Created by Square on 08/12/2021.
//

import Foundation

class FakeResponseWeatherData {
    static let url: URL = URL(string: "http://api.openweathermap.org/data/2.5/group?id=5128638,2968815&units=metric&APPID=742198267922b5ae151ee791dcb2e77f")!
    static let responseOK = HTTPURLResponse(url: URL(string: "http://api.openweathermap.org/data/2.5/group?id=5128638,2968815&units=metric&APPID=742198267922b5ae151ee791dcb2e77f")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
    static let responseKO = HTTPURLResponse(url: URL(string: "http://api.openweathermap.org/data/2.5/group?id=5128638,2968815&units=metric&APPID=742198267922b5ae151ee791dcb2e77f")!, statusCode: 500, httpVersion: nil, headerFields: nil)!

    class NetworkError: Error {}
    static let error = NetworkError()

    static var correctData: Data {
        let bundle = Bundle(for: FakeResponseWeatherData.self)
        let url = bundle.url(forResource: "Weather", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }

    static let incorrectData = "erreur".data(using: .utf8)!
}
