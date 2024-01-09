//
//  Models.swift
//  SwiftUIAppstoreSearch
//
//

import Foundation
import SwiftData

@Model
final class AppInfo {
    @Attribute(.unique) var id: Int
    var name: String
    var iconUrl: String
    var seller: String
    var appURL: String
    var genreName: String
    var screenshots: [String]
    var currentVersionReleaseDate: String
    var averageRating: Double
    var userRatingCount: Int
    var hitCount: Int
    var lastUpdate: Date
    
    init(id: Int,
        name: String) {
        self.id = id
        self.name = name
        self.iconUrl = ""
        self.seller = ""
        self.appURL = ""
        self.genreName = ""
        self.screenshots = []
        self.currentVersionReleaseDate = Date().toISO8601String()
        self.averageRating = 0
        self.userRatingCount = 0
        self.hitCount = 1
        self.lastUpdate = Date()
    }
    
    init(model: AppModel) {
        self.id = model.trackId
        self.name = model.trackName
        self.iconUrl = model.artworkUrl100 ?? model.artworkUrl60 ?? ""
        self.seller = model.sellerName ?? ""
        self.appURL = model.trackViewUrl
        self.genreName = model.primaryGenreName ?? ""
        self.screenshots = model.screenshotUrls ?? []
        self.currentVersionReleaseDate = model.currentVersionReleaseDate ?? Date().toISO8601String()
        self.averageRating = model.averageUserRating ?? 0
        self.userRatingCount = model.userRatingCount ?? 0
        self.hitCount = 1
        self.lastUpdate = Date()
    }
}
