//
//  AppInfoDataSource.swift
//  SwiftUIAppstoreSearch
//
//  Created by KAK KYOO LEE on 2024-01-08.
//

import Foundation
import SwiftData

final class AppInfoDataSource {
    private let modelContainer: ModelContainer
    private let modelContext: ModelContext

    @MainActor
    static let shared = AppInfoDataSource()

    @MainActor
    private init() {
        self.modelContainer = try! ModelContainer(for: AppInfo.self)
        self.modelContext = modelContainer.mainContext
    }

    func upsert(infos: [AppInfo]) {
        do {
            for info in infos {
                if let oldAppInfo = try self.object(id: info.id) {
                    if oldAppInfo.currentVersionReleaseDate < info.currentVersionReleaseDate {
                        modelContext.delete(oldAppInfo)
                    } else {
                        continue
                    }
                }
                   
                modelContext.insert(info)
            }
            
            try modelContext.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func object(id: Int) throws -> AppInfo? {
        let predicate = #Predicate<AppInfo> { $0.id == id }
        var descriptor = FetchDescriptor(predicate: predicate)
        descriptor.fetchLimit = 1
        var objects = try modelContext.fetch(descriptor)
        
        return objects.first
    }
    
    func objects() -> [AppInfo] {
        do {
            return try modelContext.fetch(FetchDescriptor<AppInfo>())
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    func objects(with name:String) -> [AppInfo] {
        do {
            let predicate = #Predicate<AppInfo> { $0.name.localizedStandardContains(name) }
            let descriptor = FetchDescriptor(predicate: predicate)
                
            return try modelContext.fetch(descriptor)
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    func remove(_ info: AppInfo) {
        modelContext.delete(info)
    }
}
