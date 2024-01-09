//
//  SuggestedViewCell.swift
//  SwiftUIAppstoreSearch
//
//  Created by KAK KYOO LEE on 2024-01-06.
//

import SwiftUI

struct SuggestedViewCell : View {
    let model: AppModel
    
    var body: some View {
        HStack(alignment: .center, spacing: 5) {
            AsyncImage(url: URL(string:model.appIconUrl)) { image in
                image
                    .resizable()
                    .frame(width: 50, height: 50)
            } placeholder: {
                ProgressView()
            }
            .cornerRadius(12)
            .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
            Text(model.trackName)
        }
        .foregroundStyle(.blue)
        
    }
}

