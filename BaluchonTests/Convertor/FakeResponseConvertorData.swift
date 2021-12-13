//
//  FakeResponseData.swift
//  BaluchonTests
//
//  Created by Square on 08/12/2021.
//

import Foundation

class FakeResponseConvertorData {
    static let url: URL = URL(string: "http://data.fixer.io/api/latest?access_key=e33df1e8aacc8011a519af7df2f0e3b4")!
    static let responseOK = HTTPURLResponse(url: URL(string: "http://data.fixer.io/api/latest?access_key=e33df1e8aacc8011a519af7df2f0e3b4")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
    static let responseKO = HTTPURLResponse(url: URL(string: "http://data.fixer.io/api/latest?access_key=e33df1e8aacc8011a519af7df2f0e3b4")!, statusCode: 500, httpVersion: nil, headerFields: nil)!

    class NetworkError: Error {}
    static let error = NetworkError()

    static var correctData: Data {
        let bundle = Bundle(for: FakeResponseConvertorData.self)
        let url = bundle.url(forResource: "Rates", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }

    static let incorrectData = "erreur".data(using: .utf8)!
}
