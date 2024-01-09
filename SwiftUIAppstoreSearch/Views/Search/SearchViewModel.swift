//
//  SearchViewModel.swift
//  SwiftUIAppstoreSearch
//
//

import SwiftData
import SwiftUI
import Combine

@MainActor class SearchViewModel: ObservableObject {
    @Environment(\.modelContext) private var modelContext
    @Query var apps: [AppInfo]
    @Published var searchText : String = ""
    @Published var features: Features
    
    private var task: Task<Void, Error>?
    private let formatter = ISO8601DateFormatter()
    private let service : SearchAPIService = SearchAPIService()
    
    init () {
        self.features = Features(discovers: [], suggestedList: [])
        
        _apps = Query(filter: #Predicate<AppInfo> {
                if searchText.isEmpty {
                    return true
                } else {
                    return $0.name.localizedStandardContains(searchText)
                }
            })
        
        Task {
            do {
                if let features = try await FeaturesAPIService().run(with: UUID().uuidString) {
                    self.features = features
                }
            } catch {
                print("Request features error - \(error.localizedDescription)")
            }
        }
    }
    
    func searching() {
        task?.cancel()
        task = Task {
            await requestSearch()
        }
    }
    
    func runSearch() {
        task?.cancel()
        task = Task {
            await requestSearch()
            // move to result page
        }
    }
    
    func requestSearch() async {
        do {
            guard let result = try await self.service.run(with: self.searchText) else { return }
            if Task.isCancelled { return }
            
            result.results.forEach {
                self.modelContext.insert(AppInfo(model: $0))
            }
        } catch {
            
        }
    }
}
