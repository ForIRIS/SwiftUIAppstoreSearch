//
//  SearchAPIService.swift
//  SwiftUIAppstoreSearch
//
//

import Foundation

class SearchAPIService : APIService {
    typealias T = [AppModel]
    
    private static let kTerm = "term"
    private static let kEntity = "entity"
    private static let kLimit = "limit"
    
    private let baseURL = URL(string: "https://itunes.apple.com/search")
    private let entity = "software,iPadSoftware"
    private let limit = 10
    
    func run(keyword: String) async throws -> T? {
        guard let titleForSearch = keyword.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) else {
            fatalError("Cannot add %20 to search text")
        }
        
        do {
            let request = try makeRequest(titleForSearch)
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let response = response as? HTTPURLResponse else { throw NetworkError.badResponse }
            guard response.statusCode >= 200 && response.statusCode < 300 else { throw NetworkError.badStatus }
            guard let decodedResponse = try? JSONDecoder().decode(T.self, from: data) else { throw NetworkError.failedToDecodeResponse }
            
            return decodedResponse
        } catch NetworkError.badUrl {
            print("There was an error creating the URL")
        } catch NetworkError.invalidQueries {
            print("There was an error creating the URL with queries")
        } catch NetworkError.badResponse {
            print("Did not get a valid response")
        } catch NetworkError.badStatus {
            print("Did not get a 2xx status code from the response")
        } catch NetworkError.failedToDecodeResponse {
            print("Failed to decode response into the given type")
        } catch {
            print("An error occured downloading the data")
        }
        
        return nil
    }
    
    private func makeRequest(_ keyword: String) throws -> URLRequest {
        guard let baseURL = baseURL,
              var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: false) else { throw NetworkError.badUrl }
        
        components.queryItems = [URLQueryItem(name: SearchAPIService.kTerm, value: keyword),
                                 URLQueryItem(name: SearchAPIService.kEntity, value: entity),
                                 URLQueryItem(name: SearchAPIService.kLimit, value: "\(limit)")]
        
        guard let url = components.url else { throw NetworkError.invalidQueries }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return request
    }
}
