//
//  AppInfoCell.swift
//  SwiftUIAppstoreSearch
//
//

import SwiftUI

struct AppInfoCell<Content: View> : View {
    let title: String
    let center: Text?
    let centerImage: Image?
    let bottom: Content
    
    init(
        title: String,
        center: Text? = nil,
        centerImage: Image? = nil,
        @ViewBuilder bottom: () -> Content
    ) {
        self.title = title
        self.center = center
        self.centerImage = centerImage
        self.bottom = bottom()
    }
    
    var body: some View {
        VStack(alignment: .center, spacing:5) {
            Text(title)
                .font(.caption)
                .foregroundColor(.gray)
                .frame(height: 15)
            
            if let center = center {
                center
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                    .frame(height: 30)
            } else if let centerImage = centerImage {
                centerImage
                    .resizable()
                    .foregroundColor(.gray)
                    .frame(width: 30, height: 30)
            }
            
            self.bottom
                .frame(height: 15)
        }
        .padding(EdgeInsets(top: 0, leading: 5, bottom: 5, trailing: 0))
    }
}
