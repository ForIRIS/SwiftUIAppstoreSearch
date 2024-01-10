//
//  SearchViewModel.swift
//  SwiftUIAppstoreSearch
//
//

import SwiftData
import SwiftUI
import Combine

@MainActor class SearchViewModel: ObservableObject {
    private let dataSoruce: AppInfoDataSource
    
    @Published var searchText : String = ""
    @Published var isSearching : Bool = false
    @Published var features: Features
    @Published var apps: [AppInfo] = []
    @Published var showResult: Bool
    var filteredApps: [AppInfo] {
        apps.filter {
            if searchText.isEmpty {
                return false
            } else {
                return $0.name.localizedStandardContains(searchText)
            }
        }
    }
    
    private var task: Task<Void, Error>?
    private var runTask: Task<Void, Error>?
    private let formatter = ISO8601DateFormatter()
    private let service : SearchAPIService = SearchAPIService()
    
    init (dataSource: AppInfoDataSource = AppInfoDataSource.shared) {
        self.dataSoruce = dataSource
        self.features = Features(discovers: [], suggestedList: [])
        self.showResult = false
        
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
        if let runTask = runTask, !runTask.isCancelled { return }
        
        task?.cancel()
        task = Task {
            await requestSearch()
            await MainActor.run {
                self.showResult = false
                self.apps = self.dataSoruce.objects(with: self.searchText)
            }
        }
    }
    
    func runSearch() {
        task?.cancel()
        runTask?.cancel()
        runTask = Task {
            await requestSearch()
            await MainActor.run {
                self.apps = self.dataSoruce.objects(with: self.searchText)
                self.showResult = true
            }
        }
    }
    
    
    func runSearch(with keyword: String) {
        task?.cancel()
        runTask?.cancel()
        
        self.searchText = keyword
        if self.isSearching != true { self.isSearching = true }
        
        runTask = Task {
            await requestSearch()
            await MainActor.run {
                self.apps = self.dataSoruce.objects(with: self.searchText)
                self.showResult = true
            }
        }
    }
    
    func requestSearch() async {
        do {
            guard let result = try await self.service.run(with: self.searchText) else { return }
            if Task.isCancelled { return }
            
            self.dataSoruce.upsert(infos: result.results.compactMap { AppInfo(model: $0) } )
        } catch {
            
        }
    }
}
