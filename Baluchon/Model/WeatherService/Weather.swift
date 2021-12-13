//
//  Weather.swift
//  Baluchon
//
//  Created by Square on 07/12/2021.
//

import Foundation

// MARK: - Welcome
struct OpenWeatherMap: Codable {
    let list: [List]
}

// MARK: - List
struct List: Codable {
    let weather: [Weather]
    let main: Main
}

// MARK: - Main
struct Main: Codable {
    let temp, tempMin, tempMax: Double
    
    enum CodingKeys: String, CodingKey {
        case temp
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}

// MARK: - Weather
struct Weather: Codable {
    let main, weatherDescription: String
    
    enum CodingKeys: String, CodingKey {
        case main
        case weatherDescription = "description"
    }
}
