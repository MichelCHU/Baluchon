//
//  ConvertorRatesService.swift
//  Baluchon
//
//  Created by Square on 05/11/2021.
//

import Foundation

class ConvertorRatesService {
    
    private let session: URLSession
    private let baseStringURL: String = "http://data.fixer.io/api/latest"
    
    init(session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }
    
    func getData(callback: @escaping (Result<Rates, NetworkError>) -> Void) {
        
        guard let baseURL: URL = .init(string: baseStringURL) else { return }
        let url: URL = encode(with: baseURL, and: [("access_key", "e33df1e8aacc8011a519af7df2f0e3b4")])
        #if DEBUG
        NetworkLogger(url: url).show()
        #endif
        session.dataTask(with: url, callback: callback)
    }
}

extension ConvertorRatesService: URLEncodable {}
