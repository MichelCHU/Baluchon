//
//  ConvertorRates.swift
//  Baluchon
//
//  Created by Square on 08/11/2021.
//

import Foundation

struct Rates: Decodable {
    let timestamp: Int
    let rates: [String : Double]
}
