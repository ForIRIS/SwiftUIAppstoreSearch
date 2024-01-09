//
//  DiscoverView.swift
//  SwiftUIAppstoreSearch
//
//

import SwiftUI

struct DiscoverView : View {
    var discovers: [String]
    let colums: [GridItem] = [
        GridItem(.flexible(), spacing: 5),
        GridItem(.flexible(), spacing: 5)
    ]
    
    var body: some View {
        VStack(alignment:.leading) {
            HStack {
                Text("Discover")
                    .font(.title2)
                    .bold()
                Spacer()
            }
            LazyVGrid(columns: colums) {
                ForEach(discovers, id: \.self) {
                    DiscoverViewCell(text: $0)
                }
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    DiscoverView(discovers: ["Item1", "Item2"])
}
