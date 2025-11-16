//
//  ServerURLS.swift
//  Country
//
//  Created by Madney on 14/11/2025.
//

import Foundation

enum Base_Url: String {
    case test = "https://restcountries.com/v3.1"
}

class ServerConfig {
    static let shared: ServerConfig = ServerConfig()
    
    var baseUrl: String

    init() {
        baseUrl = Base_Url.test.rawValue
    }

    func setupServerConfig() {
        baseUrl = Base_Url.test.rawValue
    }
}
