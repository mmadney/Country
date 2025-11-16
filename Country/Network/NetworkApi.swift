//
//  NetworkApi.swift
//  Event
//
//  Created by Madney on 26/03/2024.
//

import Foundation

protocol NetworkApi {
    var session: URLSession { get }
    func fetch<T: Decodable>(type: T.Type, with request: Endpoint) async throws -> T
}

extension NetworkApi {
    func fetch<T: Decodable>(type: T.Type, with request: Endpoint) async throws -> T {
        let (data, response) = try await session.data(for: request.request)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw ApiError.requestFailed(description: "Invalid response")
        }
        guard httpResponse.statusCode == 200 else {
            throw ApiError.responseUnsuccessful(description: "Status code: \(httpResponse.statusCode)")
        }
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(type, from: data)
        } catch {
            throw ApiError.jsonConversionFailure(description: error.localizedDescription)
        }
    }
}
