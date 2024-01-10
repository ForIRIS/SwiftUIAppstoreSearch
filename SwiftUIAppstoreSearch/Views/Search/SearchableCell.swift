//
//  SearchableCell.swift
//  SwiftUIAppstoreSearch
//
//  Created by KAK KYOO LEE on 2024-01-09.
//

import SwiftUI

struct SearchableCell : View {
    let text: String
    var body: some View {
        VStack {
            HStack(alignment: .center, spacing: 5) {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(.secondary)
                Text(text).font(.caption)
                Spacer()
            }
            .padding(.vertical, 5)
            Divider()
        }
        .padding(.horizontal)
    }
}

#Preview {
    SearchableCell(text: "Test")
}
