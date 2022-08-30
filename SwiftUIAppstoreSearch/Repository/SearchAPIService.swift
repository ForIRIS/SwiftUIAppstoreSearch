//
//  SearchAPIService.swift
//  SwiftUIAppstoreSearch
//
//

import Combine
import Foundation

class SearchAPIService : APIService {
    typealias T = AppModel
    
    private let baseURL = "https://itunes.apple.com/search?"
    private let appstoreKey = "software"
    
    func searchBy(title: String) -> AnyPublisher<[AppModel], Error> {
        guard let titleForSearch = title.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) else { fatalError("Cannot add %20 to search text")
        }
        
        let params = "term=\(titleForSearch)&media=\(self.appstoreKey)"
        
        var request = URLRequest(url: (URL(string: self.baseURL + params))!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return URLSession.shared.request(request)
            .decode(type: SearchResult.self, decoder: JSONDecoder())
            .tryMap {
                guard let apps : [AppModel] = $0.results else { throw RequestError.cannotParse }
                return apps
            }
            .eraseToAnyPublisher()
    }
    
}
