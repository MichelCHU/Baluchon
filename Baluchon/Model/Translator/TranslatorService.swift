//
//  TranslatorService.swift
//  Baluchon
//
//  Created by Square on 21/11/2021.
//

import Foundation

class TranslatorService {
    
    private let session: URLSession
    private let baseStringURL: String = "https://api-free.deepl.com/v2/translate"
    
    init(session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }
    
    func getData(text: String, target: String, callback: @escaping (Result<Translate, NetworkError>) -> Void){
        
        guard let baseURL: URL = .init(string: baseStringURL) else { return }
        let url: URL = encode(with: baseURL, and: [("auth_key", "cee1d066-45c2-4065-053d-62f15f9679df:fx"), ("text", "\(text)"), ("target_lang", "\(target)")])
        #if DEBUG
        NetworkLogger(url: url).show()
        #endif
        session.dataTask(with: url, callback: callback)
    }
}

extension TranslatorService: URLEncodable {}
