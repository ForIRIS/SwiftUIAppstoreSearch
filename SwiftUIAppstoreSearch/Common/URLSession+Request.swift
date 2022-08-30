//
//  URLSession+Request.swift
//  SwiftUIAppstoreSearch
//
//

import Foundation
import Combine


enum RequestError: Error {
    case request(code: Int, error: Error?)
    case cannotParse
    case unknown
}

extension URLSession {
    func request(_ request: URLRequest) -> AnyPublisher<Data, Error> {
        return URLSession.shared.dataTaskPublisher(for: request)
            .retry(3)
            .receive(on: DispatchQueue.main)
            .tryMap { data, response -> Data in
                let httpResponse = response as? HTTPURLResponse
                if let httpResponse = httpResponse, 200..<300 ~= httpResponse.statusCode {
                    do {
                        _ = try JSONDecoder().decode(SearchResult.self, from: data)
                      } catch let jsonError as NSError {
                        print("JSON decode failed: \(jsonError.localizedDescription)")
                      }
                    return data
                }
                else if let httpResponse = httpResponse {
                    throw RequestError.request(code: httpResponse.statusCode,
                                               error: NSError(domain: httpResponse.description,
                                                              code: httpResponse.statusCode,
                                                              userInfo: httpResponse.allHeaderFields as? [String : Any]))
                }     else {
                    throw RequestError.unknown
                }
           
            }
            .eraseToAnyPublisher()
    }
}
