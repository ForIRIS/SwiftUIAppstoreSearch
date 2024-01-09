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
        VStack(spacing: 4) {
            HStack(alignment: .center, spacing: 5) {
                Image(systemName: "magnifyingglass")
                Text(text)
                Spacer()
            }
            .foregroundStyle(.secondary)
            Divider()
        }
        .padding(EdgeInsets(top: 15, leading: 5, bottom: 5, trailing: 15))
    }
}

#Preview {
    SearchableCell(text: "Test")
}
