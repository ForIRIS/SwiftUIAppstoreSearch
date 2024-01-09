//
//  FeaturesAPIService.swift
//  SwiftUIAppstoreSearch
//
//  This is Mock-up service for home screen
//

import Foundation

class FeaturesAPIService : APIService {
    typealias T = Features
    
    func run(with keyword: String) async throws -> T? {
        guard let titleForSearch = keyword.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) else {
            fatalError("Cannot add %20 to search text")
        }
        
        do {
            guard let jsonUrl = Bundle.main.url(forResource: "features", withExtension: "json") else { throw NetworkError.badUrl }
            guard let data = try? Data(contentsOf: jsonUrl) else { throw NetworkError.badResponse }
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
