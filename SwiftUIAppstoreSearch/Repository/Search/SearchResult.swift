//
//  SearchResult.swift
//  SwiftUIAppstoreSearch
//
//

import Foundation

struct SearchResult : Decodable {
    let resultCount : Int
    let results : [AppModel]
    
    enum CodingKeys: String, CodingKey {
            case resultCount
            case results
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        resultCount = try values.decode(Int.self, forKey: .resultCount)
        results = try values.decode([AppModel].self, forKey: .results)
    }
}
