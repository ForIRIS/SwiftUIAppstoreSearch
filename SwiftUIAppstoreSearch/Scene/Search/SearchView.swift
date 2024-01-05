//
//  SearchView.swift
//  SwiftUIAppstoreSearch
//
//

import SwiftUI

struct SearchView: View {
    @ObservedObject private var viewModel = SearchViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.items) { item in
                ZStack {
                    NavigationLink(destination: AppDetailView(data: item)) {
                        EmptyView()
                    }
                    .opacity(0.0)
                    .buttonStyle(.plain)
                
                    SearchCell(data: item)
                }
            }
            .listStyle(.plain)
            .searchable(text: $viewModel.searchText,
                        prompt: "Games, Apps, Stories and More") {
                ForEach(viewModel.items, id: \.self) { item in
                    Text(item.title).searchCompletion(viewModel.searchText)
                }
            }
            .navigationBarTitle(Text("Search"))
        }
    }
}

#Preview {
    SearchView()
}
