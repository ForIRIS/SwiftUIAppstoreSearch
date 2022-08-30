//
//  SearchViewModel.swift
//  SwiftUIAppstoreSearch
//
//

import SwiftUI
import Combine

final class SearchViewModel: ObservableObject {
    @Published var searchText : String = ""
    @Published private (set) var items = [AppDisplayData]()
    
    private let formatter = ISO8601DateFormatter()
    private let service : SearchAPIService = SearchAPIService()
    
    private var searchCancellable: Cancellable? {
        didSet {
            oldValue?.cancel()
        }
    }
    
    deinit {
        searchCancellable?.cancel()
    }
    
    init () {
        searchCancellable = $searchText
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .removeDuplicates()
            .filter { !$0.isEmpty && $0.first != " " }
            .flatMap { (searchString) -> AnyPublisher<[AppModel], Never> in
                return self.service.searchBy(title: searchString)
                    .replaceError(with: []) //TODO: Handle Errors
                    .eraseToAnyPublisher()
            }
            .map {
                self.appsToDisplay(apps: $0)
            }
            .replaceError(with: [])
            .assign(to: \.items, on: self)
    }
    
    private func appsToDisplay(apps: [AppModel]) -> [AppDisplayData] {
        var displayDatas = [AppDisplayData]()
                
        apps.forEach {
            let displayData = AppDisplayData(id: $0.bundleId,
                                             title: $0.trackName,
                                             author: $0.artistName ?? "",
                                             seller: $0.sellerName,
                                             sellerUrl: $0.sellerUrl,
                                             icon:  URL(string:$0.artworkUrl100 ?? "") ,
                                             date: formatter.date(from: $0.currentVersionReleaseDate ?? formatter.string(from: Date()))!,
                                             screenshotUrls: $0.screenshotUrls,
                                             description: $0.description,
                                             rating: $0.averageUserRatingForCurrentVersion,
                                             ratingCount: $0.userRatingCountForCurrentVersion,
                                             languages: $0.languageCodesISO2A,
                                             size: Float($0.fileSizeBytes ?? "0")! / 1024 / 1024,
                                             appUrl: $0.trackViewUrl)
            displayDatas.append(displayData)
        }
        
        return displayDatas
    }
}
