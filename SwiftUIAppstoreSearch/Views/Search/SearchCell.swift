//
//  SearchCell.swift
//  SwiftUIAppstoreSearch
//
//

import SwiftUI
import CachedAsyncImage

struct SearchCell: View {
    let info: AppInfo
    @Environment(\.openURL) var openURL
    
    private let placeholderImg = UIImage(named: "placeholder")!
    
    var body : some View {
        VStack(alignment: .leading, spacing: 0) {
            topInfos
            
            HStack {
                StarRatingView(Float(info.averageRating))
                Text(formatNumber(info.userRatingCount))
                    .font(.footnote)
            }
            .frame(alignment: .leading)
            .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
            
            previews
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
    }
    
    var topInfos: some View {
        HStack {
            // App Icon image
            CachedAsyncImage(url: URL(string:info.iconUrl)) { image in
                image.resizable()
            } placeholder: {
                Image(uiImage: placeholderImg)
            }
            .frame(width: 50, height: 50)
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(.gray.opacity(0.1), lineWidth: 1)
            )
            
            
            // Title and Seller
            VStack(alignment: .leading) {
                Text(info.name)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .lineLimit(2)
                
                Text(info.seller)
                    .font(.footnote)
                    .lineLimit(1)
            }
            
            Spacer()
            
            // Goto appstore page
            Button {
                openURL(URL(string: info.appURL)!)
            } label: {
                Text("Get")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
            }
            .frame(width:56, height:26)
            .background(Color(UIColor.secondarySystemBackground))
            .cornerRadius(13)
        }
        .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
    }
    
    var previews: some View {
        HStack(alignment: .center, spacing: 10) {
            ForEach(info.getThumbnails(), id: \.self) { imageUrl in
                CachedAsyncImage(url: URL(string: imageUrl)) {
                    $0
                        .resizable()
                        .cornerRadius(8)
                } placeholder: {
                    ProgressView()
                }
            }
        }
        .aspectRatio(16.0/9.0, contentMode: .fit)
        .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
    }
}

#Preview {
    SearchCell(info: AppInfo(id: 1, name: "Test"))
}
