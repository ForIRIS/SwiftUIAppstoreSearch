//
//  SearchView.swift
//  SwiftUIAppstoreSearch
//
//

import SwiftUI

struct SearchView: View {
    @ObservedObject private var viewModel = SearchViewModel()

    var body: some View {
        ZStack {
            if viewModel.apps.isEmpty {
                features
            } else {
                searchableList
            }
        }
        .navigationTitle("Search")
        .searchable(text: $viewModel.searchText,
                    prompt: "Games, Apps, Stories and More")
        .onAppear(perform: viewModel.runSearch)
        .onSubmit(of: .search, viewModel.runSearch)
    }
    
    var features: some View {
        Group {
            if !viewModel.features.discovers.isEmpty {
                DiscoverView(discovers: viewModel.features.discovers)
            }
            if !viewModel.features.suggestedList.isEmpty {
                SuggestionView(suggestedList: viewModel.features.suggestedList)
            }
        }
    }
    
    var searchableList: some View {
        List (viewModel.apps) { item in
        }
    }
}

#Preview {
    SearchView()
}
