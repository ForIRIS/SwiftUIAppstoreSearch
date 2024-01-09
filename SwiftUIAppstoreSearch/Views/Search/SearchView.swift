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
            if viewModel.filteredApps.isEmpty {
                features
            } else {
                searchableList
            }
        }
        .searchable(text: $viewModel.searchText,
                    prompt: "Games, Apps, Stories and More")
        .onAppear(perform: viewModel.searching)
        .onChange(of: viewModel.searchText, viewModel.searching)
        .onSubmit(of: .search, viewModel.runSearch)
    }
    
    var features: some View {
        ScrollView(.vertical) {
            if !viewModel.features.discovers.isEmpty {
                DiscoverView(discovers: viewModel.features.discovers)
            }
            if !viewModel.features.suggestedList.isEmpty {
                SuggestionView(suggestedList: viewModel.features.suggestedList)
            }
            Spacer()
        }
    }
    
    var searchableList: some View {
        ScrollView(.vertical) {
            LazyVGrid(columns: [GridItem()]) {
                ForEach(viewModel.filteredApps) { item in
                    if viewModel.showResult {
                        SearchCell(info: item)
                    } else {
                        SearchableCell(text: item.name)
                            .onTapGesture {
                                viewModel.searchText = item.name
                                viewModel.runSearch()
                            }
                    }
                }
            }
            Spacer()
        }
    }
}

#Preview {
    SearchView()
}
