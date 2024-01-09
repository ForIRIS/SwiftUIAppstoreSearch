//
//  SearchAPIService.swift
//  SwiftUIAppstoreSearch
//
//

import Foundation

class SearchAPIService : APIService {
    typealias T = SearchResult
    
    private static let kTerm = "term"
    private static let kEntity = "entity"
    private static let kLimit = "limit"
    
    private let baseURL = URL(string: "https://itunes.apple.com/search")
    private let entity = "software"
    private let limit = 10
    
    func run(with keyword: String) async throws -> T? {
        guard let titleForSearch = keyword.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) else {
            fatalError("Cannot add %20 to search text")
        }
        
        do {
            let request = try makeRequest(titleForSearch)
            let data = try await URLSession.shared.run(for: request)
            guard let decodedResponse = try? JSONDecoder().decode(T.self, from: data) else { throw NetworkError.failedToDecodeResponse }
            
            return decodedResponse
        } catch NetworkError.badUrl {
            print("There was an error creating the URL")
        } catch NetworkError.invalidQueries {
            print("There was an error creating the URL with queries")
        } catch NetworkError.badResponse {
            print("Did not get a valid response")
        } catch NetworkError.badStatus(let status) {
            print("Did not get a \(status) status code from the response")
        } catch NetworkError.failedToDecodeResponse {
            print("Failed to decode response into the given type")
        } catch {
            print("Invalid error : \(error.localizedDescription)")
        }
        
        return nil
    }
}

extension SearchAPIService {
    fileprivate func makeRequest(_ keyword: String) throws -> URLRequest {
        guard let baseURL = baseURL,
              var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: false) else { throw NetworkError.badUrl }
        
        components.queryItems = [URLQueryItem(name: SearchAPIService.kTerm,   value: keyword),
                                 URLQueryItem(name: SearchAPIService.kEntity, value: entity),
                                 URLQueryItem(name: SearchAPIService.kLimit,  value: "\(limit)")]
        
        guard let url = components.url else { throw NetworkError.invalidQueries }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return request
    }
}
