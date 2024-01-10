//
//  DiscoverView.swift
//  SwiftUIAppstoreSearch
//
//

import SwiftUI

struct DiscoverView : View {
    @EnvironmentObject var viewModel: SearchViewModel
    
    var discovers: [String]
    let colums: [GridItem] = [
        GridItem(.flexible(), spacing: 15),
        GridItem(.flexible(), spacing: 15)
    ]
    
    var body: some View {
        VStack(alignment:.leading) {
            HStack {
                Text("Discover")
                    .font(.title2)
                    .bold()
                Spacer()
            }
            LazyVGrid(columns: colums, spacing: 0) {
                let lastLineStart = discovers.count - max( 2, discovers.count % 2 )
                ForEach(0..<discovers.count, id: \.self) { index in
                    DiscoverViewCell(text: discovers[index])
                        .overlay(
                            Rectangle()
                                .fill(index < lastLineStart ? Color.gray.opacity(0.1) : Color.clear)
                                .frame(height: 1, alignment: .bottom),
                            alignment: .bottom
                        )
                        .onTapGesture {
                            viewModel.runSearch(with:discovers[index])
                        }
                }
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    DiscoverView(discovers: ["Item1", "Item2", "Item3", "Item4", "Item5"])
}
