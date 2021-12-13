//
//  WeatherService.swift
//  Baluchon
//
//  Created by Square on 11/11/2021.
//

import Foundation

class WeatherService {
    
    private let session: URLSession
    private let baseStringURL: String = "http://api.openweathermap.org/data/2.5/group"
    
    init(session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }
    
    func getData(callback: @escaping (Result<OpenWeatherMap, NetworkError>) -> Void) {

        guard let baseURL: URL = .init(string: baseStringURL) else { return }
        let url: URL = encode(with: baseURL, and: [("id", "5128638,2968815"), ("units", "metric"), ("APPID", "742198267922b5ae151ee791dcb2e77f")])
        #if DEBUG
        NetworkLogger(url: url).show()
        #endif
        session.dataTask(with: url, callback: callback)
    }
}

extension WeatherService: URLEncodable {}
