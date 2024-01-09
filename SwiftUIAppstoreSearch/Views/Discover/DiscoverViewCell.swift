//
//  DiscoverViewCell.swift
//  SwiftUIAppstoreSearch
//
//  Created by KAK KYOO LEE on 2024-01-07.
//

import SwiftUI

struct DiscoverViewCell : View {
    let text: String
    var body: some View {
        HStack(alignment: .center, spacing: 5) {
            Image(systemName: "magnifyingglass")
            Text(text)
            Spacer()
        }
        .foregroundStyle(.blue)
        .frame(height: 50)
    }
}

#Preview {
    DiscoverViewCell(text: "Preview")
}
