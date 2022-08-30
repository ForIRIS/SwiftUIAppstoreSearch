//
//  AppDetailInfoView.swift
//  SwiftUIAppstoreSearch
//  Displays the 4 basic information extracted from the Model.
//

import SwiftUI

struct AppDetailInfoView : View {
    private let placeholderImg = UIImage(named: "placeholder")!
    let displayData: AppDisplayData
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                if let rating = displayData.rating {
                    AppInfoCell(title:String(format: "\(formatNumber(displayData.ratingCount!)) RATINGS"),
                                center: Text(String(format: "%.1f", rating))) {
                        StarRatingView(Float(rating))
                    }
                    
                    Divider().frame(height: 40)
                }
                
                if #available(iOS 15.0, *) { // person.crop.square is iOS 15+ image
                    AppInfoCell(title: "DEVELOPER",
                                centerImage: Image(systemName: "person.crop.square")) {
                        Text(displayData.author)
                            .font(.caption2)
                            .foregroundColor(.gray)
                    }
                }
                
                if let languages = displayData.languages {
                    Divider().frame(height: 40)
                    
                    AppInfoCell(title: "LANGUAGE",
                                center: Text(languages[0])) {
                        if languages.count > 1 {
                            Text(String(format: "+ %d More", languages.count - 1))
                                .font(.caption2)
                                .foregroundColor(.gray)
                        } else {
                            Text("")
                        }
                    }
                }
                if let size = displayData.size {
                    Divider().frame(height: 40)
                    
                    AppInfoCell(title: "SIZE",
                                center: Text(String(format: "%.1f", size))) {
                        Text("MB")
                            .font(.caption2)
                            .foregroundColor(.gray)
                    }
                }
            }
        }
    }
}
