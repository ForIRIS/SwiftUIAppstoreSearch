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
                .navigationBarBackButtonHidden()
                .navigationDestination(for: AppInfo.self) { appInfo in
                    AppDetailView(info: appInfo)
                }
        }
    }
}

#Preview {
    ContentView()
}
