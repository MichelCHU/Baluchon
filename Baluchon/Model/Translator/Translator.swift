//
//  Translator.swift
//  Baluchon
//
//  Created by Square on 21/11/2021.
//

import Foundation

// MARK: - Welcome
struct Translate: Decodable {
    let translations: [Translation]
}

// MARK: - Translation
struct Translation: Decodable {
    let detectedSourceLanguage, text: String
    
    enum CodingKeys: String, CodingKey {
        case detectedSourceLanguage = "detected_source_language"
        case text
    }
}
