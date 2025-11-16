//
//  EndPoint.swift
//  Event
//
//  Created by Madney on 26/03/2024.
//

import Foundation

enum RequestType: String {
    case GET
    case POST
}

protocol Endpoint {
    var base: String { get }
    var path: String { get }
    var requestType: RequestType { get }
    var paramter: [String: Any]? { get }
}

extension Endpoint {
    var urlComponents: URLComponents {
        var components = URLComponents(string: base)!
        components.path = path
        return components
    }

    var request: URLRequest {
        let url = URL(string: base + path)!
        var request = URLRequest(url: url)
        request.httpMethod = requestType.rawValue
        if let paramter = paramter {
            request.httpBody = try! JSONSerialization.data(withJSONObject: paramter)
        }
        return request
    }
}
