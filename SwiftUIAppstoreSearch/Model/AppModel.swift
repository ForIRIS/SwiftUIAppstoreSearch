//
//  AppModel.swift
//  SwiftUIAppstoreSearch
//
//

import Foundation

class AppModel : Decodable, Hashable {
    /// comment is appstore properties.
    let trackId : Int
    let trackName : String
    let trackViewUrl : String           // app detail page
    let sellerName : String?
    let artworkUrl60 : String?
    let artworkUrl100 : String?
    let primaryGenreName : String?      // Primary category
    let screenshotUrls: [String]?       // Screenshots URLs
    let averageUserRating : Double?
    let userRatingCount : Int?
    let currentVersionReleaseDate: String?
    let releaseNotes: String?
    let description: String?
    
    init(id: Int, name: String, sellerName: String, artworkUrl60: String) {
        self.trackId = id
        self.trackName = name
        self.trackViewUrl = ""
        self.sellerName = sellerName
        self.artworkUrl60 = artworkUrl60
        self.artworkUrl100 = nil
        self.primaryGenreName = nil
        self.screenshotUrls = nil
        self.averageUserRating = nil
        self.userRatingCount = nil
        self.currentVersionReleaseDate = nil
        self.releaseNotes = nil
        self.description = nil
    }
    
    var appIconUrl: String {
        artworkUrl100 ?? artworkUrl60 ?? ""
    }
    
    static func == (lhs: AppModel, rhs: AppModel) -> Bool {
        lhs.trackId == rhs.trackId
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(trackId)
    }
}
