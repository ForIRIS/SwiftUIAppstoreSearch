//
//  SwiftUIAppstoreSearch.swift
//  SwiftUIAppstoreSearch
//
//

import SwiftUI
import SwiftData

@main
struct SwiftUIAppstoreSearchApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [AppInfo.self])
    }
}
