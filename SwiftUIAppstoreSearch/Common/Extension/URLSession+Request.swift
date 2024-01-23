//
//  URLSession+Request.swift
//  SwiftUIAppstoreSearch
//
//

import Foundation
import Combine


extension URLSession {
    func run(for request: URLRequest) async throws -> Data {
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let response = response as? HTTPURLResponse else { throw NetworkError.badResponse }
        guard response.statusCode >= 200 && response.statusCode < 300 else { throw NetworkError.badStatus(response.statusCode) }
        
        return data
    }
}
