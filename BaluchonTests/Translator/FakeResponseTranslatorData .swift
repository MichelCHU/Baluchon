//
//  FakeResponseTranslatorData .swift
//  BaluchonTests
//
//  Created by Square on 08/12/2021.
//

import Foundation

class FakeResponseTranslatorData {
    
static let url: URL = URL(string: "https://api-free.deepl.com/v2/translate?auth_key=cee1d066-45c2-4065-053d-62f15f9679df:fx&text=Bonjour&target_lang=EN")!
static let responseOK = HTTPURLResponse(url: URL(string: "https://api-free.deepl.com/v2/translate?auth_key=cee1d066-45c2-4065-053d-62f15f9679df:fx&text=Bonjour&target_lang=EN")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
static let responseKO = HTTPURLResponse(url: URL(string: "https://api-free.deepl.com/v2/translate?auth_key=cee1d066-45c2-4065-053d-62f15f9679df:fx&text=Bonjour&target_lang=EN")!, statusCode: 500, httpVersion: nil, headerFields: nil)!

class NetworkError: Error {}
static let error = NetworkError()

static var correctData: Data {
    let bundle = Bundle(for: FakeResponseTranslatorData.self)
    let url = bundle.url(forResource: "Translator", withExtension: "json")
    let data = try! Data(contentsOf: url!)
    return data
}

static let incorrectData = "erreur".data(using: .utf8)!
    
}
