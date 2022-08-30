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
    let screenshotUrls: [String]?
    let description: String?
    let rating: Double?
    let ratingCount: Int?
    let languages: [String]?
    let size: Float?
    let appUrl: String?
    
    func fetchImage(completion: @escaping(UIImage?) -> Void) {
        guard let icon = self.icon else {
            return
        }
        
        _ = ImageLoader.shared.loadImage(from: icon, date: date)
            .replaceError(with: nil)
            .sink { image in
                completion(image)
            }
    }
    
    func fetchScreenshot(completion: @escaping(UIImage?) -> Void) {
        guard let screenshotUrls = self.screenshotUrls else {
            return
        }
        
        for idx in stride(from: 0, to: min(3,screenshotUrls.count), by: 1) {
            _ = ImageLoader.shared.loadImage(from: screenshotUrls[idx], date: date)
                .replaceError(with: nil)
                .sink { image in
                    completion(image)
                }
        }
    }
}
