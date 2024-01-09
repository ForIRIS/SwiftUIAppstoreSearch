//
//  ContentView.swift
//  SwiftUIAppstoreSearch
//
//

import SwiftUI

struct ContentView: View {
    @State private var navPath = NavigationPath()
    
    var body: some View {
        ZStack {
            NavigationStack(path: $navPath) {
                SearchView()
                    .navigationDestination(for: AppInfo.self) { appInfo in
                        AppDetailView(info: appInfo)
                    }
                    .navigationDestination(for: [AppInfo].self) { appInfos in
                        SearchResultView(list: appInfos)
                    }
            }
        }
    }
}

#Preview {
    ContentView()
}
