//
//  ContentView.swift
//  SwiftUIAppstoreSearch
//
//

import SwiftUI

struct ContentView: View {
    @State private var navPath = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $navPath) {
            SearchView()
                .navigationTitle("Search")
                .navigationDestination(for: AppInfo.self) { appInfo in
                    AppDetailView(info: appInfo)
                }
                .navigationDestination(for: [AppInfo].self) { appInfos in
                    SearchResultView(list: appInfos)
                }
        }
    }
}

#Preview {
    ContentView()
}
