//
//  SearchView.swift
//  SwiftUIAppstoreSearch
//
//

import SwiftUI

struct SearchView: View {
    @State private var viewModel = SearchViewModel()

    var body: some View {
        ZStack {
            if viewModel.showFeatures {
                features
            } else {
                searchableList
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Text("Search")
                    .bold()
                    .font(.largeTitle)
            }
        }
        .searchable(text: $viewModel.searchText,
                    isPresented: $viewModel.isSearching,
                    prompt: "Games, Apps, Stories and More")
        .onChange(of: viewModel.searchText, viewModel.searching)
        .onSubmit(of: .search, viewModel.runSearch)
        .environment(viewModel)
        .scrollDismissesKeyboard(.immediately)
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
                        NavigationLink(value: item) {
                            SearchCell(info: item)
                        }.buttonStyle(.plain)
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
