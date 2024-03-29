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
    var averageRating: Float
    var userRatingCount: Int
    var lastUpdate: Date
    var releaseNotes: String
    var appDescription: String
    
    init(id: Int,
         name: String,
         seller: String = "",
         iconUrl: String = "") {
        self.id = id
        self.name = name
        self.iconUrl = iconUrl
        self.seller = seller
        self.appURL = ""
        self.genreName = ""
        self.screenshots = []
        self.currentVersionReleaseDate = Date().toISO8601String()
        self.averageRating = 0
        self.userRatingCount = 0
        self.lastUpdate = Date()
        self.releaseNotes = ""
        self.appDescription = ""
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
        self.averageRating = Float(model.averageUserRating ?? 0)
        self.userRatingCount = model.userRatingCount ?? 0
        self.releaseNotes = model.releaseNotes ?? ""
        self.appDescription = model.description ?? ""
        self.lastUpdate = Date()
    }
}

extension AppInfo {
    func hasLandscapeScreenshot() -> Bool {
        guard let urlString = screenshots.first else { return false }
        
        let pattern = #"/(\d+)x(\d+)bb"# // Assumes "widthxheightbb" format
        let regex = try! NSRegularExpression(pattern: pattern, options: [])
        let range = NSRange(location: 0, length: urlString.utf16.count)

        guard let match = regex.firstMatch(in: urlString, options: [], range: range) else {
            return false
        }

        // Extract width and height from the matched range
        if let widthRange = Range(match.range(at: 1), in: urlString),
           let heightRange = Range(match.range(at: 2), in: urlString),
           let width = Int(urlString[widthRange]),
           let height = Int(urlString[heightRange]) {
            return width > height
        }
        
        return false
    }
    
    func getScreenshotSize() -> (Double, Double)? {
        guard let urlString = screenshots.first else { return nil }
        
        let pattern = #"/(\d+)x(\d+)bb"# // Assumes "widthxheightbb" format
        let regex = try! NSRegularExpression(pattern: pattern, options: [])
        let range = NSRange(location: 0, length: urlString.utf16.count)

        guard let match = regex.firstMatch(in: urlString, options: [], range: range) else {
            return nil
        }

        // Extract width and height from the matched range
        if let widthRange = Range(match.range(at: 1), in: urlString),
           let heightRange = Range(match.range(at: 2), in: urlString),
           let width = Double(urlString[widthRange]),
           let height = Double(urlString[heightRange]) {
            return (width, height)
        }
        
        return nil
    }
    
    func getThumbnails() -> [String] {
        if hasLandscapeScreenshot() {
            if let thumbnail = screenshots.first {
                return [thumbnail]
            }
        } else if screenshots.count > 2  {
            return Array<String>(screenshots[0..<3])
        }
        
        return []
    }
}
