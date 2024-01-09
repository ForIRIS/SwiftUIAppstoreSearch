//
//  SuggestedViewCell.swift
//  SwiftUIAppstoreSearch
//
//  Created by KAK KYOO LEE on 2024-01-06.
//

import SwiftUI

struct SuggestedViewCell : View {
    @Environment(\.openURL) var openURL
    let model: AppModel
    
    var body: some View {
        HStack(alignment: .center) {
            AsyncImage(url: URL(string:model.appIconUrl)) { image in
                image
                    .resizable()
                    .frame(width: 60, height: 60)
            } placeholder: {
                ProgressView()
            }
            .cornerRadius(12)
            
            VStack(alignment: .leading) {
                Text(model.trackName)
                    .font(.title3)
                    .foregroundStyle(.primary)
                if let sellerName = model.sellerName {
                    Text(sellerName)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            Spacer()
            Button {
                openURL(URL(string: model.trackViewUrl)!)
            } label: {
                Text("Get")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
            }
            .frame(width:78, height:32)
            .background(Color(UIColor.secondarySystemBackground))
            .cornerRadius(16)
        }
        .frame(maxWidth:.infinity)
    }
}

#Preview {
    SuggestedViewCell(model: AppModel(id: 1,
                                      name: "test",
                                      sellerName: "test seller",
                                      artworkUrl60: "https://is1-ssl.mzstatic.com/image/thumb/Purple126/v4/f7/5f/3c/f75f3cc9-4bc7-ec33-5f62-07acd759a26d/AppIcon-0-0-1x_U007emarketing-0-0-0-7-0-0-sRGB-0-0-0-GLES2_U002c0-512MB-85-220-0-0.png/60x60bb.jpg"))
}
