//
//  CountryApiRequest.swift
//  Country
//
//  Created by Madney on 14/11/2025.
//

import Foundation

enum CountryAPIRequest {
    case fetchAllCountries
}

extension CountryAPIRequest: Endpoint {
    var base: String {
        switch self {
        case .fetchAllCountries: return ServerConfig.shared.baseUrl
        }
    }

    var path: String {
        switch self {
        case .fetchAllCountries: return ServerPaths.countryPath
        }
    }

    var requestType: RequestType {
        switch self {
        case .fetchAllCountries: return .GET
        }
    }

    var paramter: [String: Any]? {
        switch self {
        case .fetchAllCountries: nil
        }
    }
}
