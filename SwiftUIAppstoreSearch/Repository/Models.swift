//
//  Models.swift
//  SwiftUIAppstoreSearch
//
//

import Foundation

struct SearchResult : Decodable {
    let resultCount : Int
    let results : [AppModel]?
    
    enum CodingKeys: String, CodingKey {
            case resultCount
            case results
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        resultCount = try values.decode(Int.self, forKey: .resultCount)
        results = try values.decode([AppModel]?.self, forKey: .results)
    }
}

struct AppModel : Decodable {  /// comment is appstore properties.
    let kind : String
    let trackId : Int
    let trackName : String
    let trackViewUrl : String           // app detail page
    let bundleId : String
    let artistName : String?
    let artistViewUrl : String?         // developer view
    let sellerName : String?
    let sellerUrl : String?             // seller homepage
    let artworkUrl60 : String?
    let artworkUrl100 : String?
    let viewURL : String?
    let artistId : Int?
    let currency : String?
    let price: Float?
    let isGameCenterEnabled : Bool?
    let formattedPrice : String?        // sell price
    let primaryGenreId : Int?           // Primary category IDs
    let primaryGenreName : String?      // Primary category
    let genreIds : [String]?            // All categories IDs
    let screenshotUrls: [String]?       // Screenshots URLs
    let features: [String]?             // Support device
    let averageUserRatingForCurrentVersion : Double?
    let userRatingCountForCurrentVersion : Int?
    let averageUserRating : Double?
    let userRatingCount : Int?
    let trackContentRating : String?
    let releaseNotes: String?           // new features release note
    let releaseDate: String?            // new features update date
    let currentVersionReleaseDate: String?
    let languageCodesISO2A: [String]?   // supported language list
    let description: String?
    let fileSizeBytes: String?
}
