//
//  AppDisplayData.swift
//  SwiftUIAppstoreSearch
//
//

import Foundation
import SwiftUI

struct AppDisplayData: Identifiable, Hashable {
    let id: String
    let title: String
    let author: String
    let seller: String?
    let sellerUrl: String?
    let icon: URL?
    let date: Date
    let screenshotUrls: [String]
    let description: String?
    let rating: Double?
    let ratingCount: Int?
    let languages: [String]?
    let size: Float?
    let appUrl: String?
}
