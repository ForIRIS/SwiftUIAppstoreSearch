//
//  Dummys.swift
//  SwiftUIAppstoreSearch
//
//

import Foundation

#if DEBUG
struct Dummy {
    static let displayData : AppDisplayData = AppDisplayData(id: "com.app.test",
                                                             title: "Preview",
                                                             author: "Artist",
                                                             seller: "Seller",
                                                             sellerUrl: "https://www.google.com",
                                                             icon:URL(string:"https://is2-ssl.mzstatic.com/image/thumb/Purple124/v4/cf/3b/1f/cf3b1f95-675a-d100-f91f-0f5ca1f9f8e2/AppIcon-0-0-1x_U007emarketing-0-0-0-10-0-0-sRGB-0-0-0-GLES2_U002c0-512MB-85-220-0-0.png/100x100bb.jpg")!,
                                                             date: Date(), screenshotUrls: [
                                                                "https://is4-ssl.mzstatic.com/image/thumb/PurpleSource122/v4/33/ab/e0/33abe014-f373-331d-9150-4e6ef0fa4764/6448734c-bf84-4963-885c-4ac757d6a736_EN-2208x1242.jpg/406x228bb.jpg",
                                                                "https://is2-ssl.mzstatic.com/image/thumb/Purple122/v4/23/6a/a8/236aa8e4-215a-cbc0-ce6a-1bdff2d59f0e/4a4f9583-922c-418f-b360-c2c770004322_EN-2208x1242-_U56fe2.jpg/406x228bb.jpg",
                                                                "https://is1-ssl.mzstatic.com/image/thumb/Purple122/v4/3f/c5/dd/3fc5dd8c-454c-ccb5-b2df-98786eafcdd0/2af445e5-002e-4b07-b57f-d2a2e74ffbe5_EN_2208x1242__U56fe_U4e09.jpg/406x228bb.jpg"],
                                                             description: "Test",
                                                             rating: 4.3,
                                                             ratingCount: 123,
                                                             languages: ["EN"],
                                                             size: 123.45,
                                                             appUrl: "https://apps.apple.com/us/app/genshin-impact/id1517783697?uo=4")
    
    static let appdata : AppModel = AppModel(kind: "software",
                                             trackId: 123456789,
                                             trackName: "Preview",
                                             trackViewUrl: "https",
                                             bundleId: "com.app.test",
                                             artistName: "Artist",
                                             artistViewUrl: nil,
                                             sellerName: "https://www.google.com",
                                             sellerUrl: nil,
                                             artworkUrl60: nil,
                                             artworkUrl100: "https://is2-ssl.mzstatic.com/image/thumb/Purple124/v4/cf/3b/1f/cf3b1f95-675a-d100-f91f-0f5ca1f9f8e2/AppIcon-0-0-1x_U007emarketing-0-0-0-10-0-0-sRGB-0-0-0-GLES2_U002c0-512MB-85-220-0-0.png/100x100bb.jpg",
                                             viewURL: "https://apps.apple.com/us/app/genshin-impact/id1517783697?uo=4",
                                             artistId: nil,
                                             currency: nil,
                                             price: nil,
                                             isGameCenterEnabled: nil,
                                             formattedPrice: nil,
                                             primaryGenreId: 1,
                                             primaryGenreName: nil,
                                             genreIds: nil,
                                             screenshotUrls: [
                                                 "https://is4-ssl.mzstatic.com/image/thumb/PurpleSource122/v4/33/ab/e0/33abe014-f373-331d-9150-4e6ef0fa4764/6448734c-bf84-4963-885c-4ac757d6a736_EN-2208x1242.jpg/406x228bb.jpg",
                                                 "https://is2-ssl.mzstatic.com/image/thumb/Purple122/v4/23/6a/a8/236aa8e4-215a-cbc0-ce6a-1bdff2d59f0e/4a4f9583-922c-418f-b360-c2c770004322_EN-2208x1242-_U56fe2.jpg/406x228bb.jpg",
                                                 "https://is1-ssl.mzstatic.com/image/thumb/Purple122/v4/3f/c5/dd/3fc5dd8c-454c-ccb5-b2df-98786eafcdd0/2af445e5-002e-4b07-b57f-d2a2e74ffbe5_EN_2208x1242__U56fe_U4e09.jpg/406x228bb.jpg"],
                                             features: nil,
                                             averageUserRatingForCurrentVersion: 4.3,
                                             userRatingCountForCurrentVersion: 123,
                                             averageUserRating: 4.5,
                                             userRatingCount: 1234,
                                             trackContentRating: nil,
                                             releaseNotes: nil,
                                             releaseDate: "2022-07-07T16:43:56Z",
                                             currentVersionReleaseDate: "2022-07-08T16:43:56Z",
                                             languageCodesISO2A: ["EN"],
                                             description: "Test",
                                             fileSizeBytes: "123456789")
}
#endif
