//
//  Error.swift
//  Baluchon
//
//  Created by Square on 22/11/2021.
//

import Foundation

enum NetworkError: Error {
    case noData, invalidResponse, undecodableData
}

extension NetworkError: CustomStringConvertible {
    var description: String {
        switch self {
        case .noData: return "The service is momentarily unavaible"
        case .invalidResponse: return "The service is momentarily unavaible"
        case .undecodableData: return "The service is momentarily unavaible"
        }
    }
}


