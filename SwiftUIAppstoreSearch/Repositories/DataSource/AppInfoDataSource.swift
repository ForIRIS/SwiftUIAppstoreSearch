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
                if let oldAppInfo = try self.object(id: info.id),
                   oldAppInfo.currentVersionReleaseDate < info.currentVersionReleaseDate {
                    modelContext.delete(oldAppInfo)
                }
                   
                modelContext.insert(info)
            }
            
            try modelContext.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func object(id: Int) throws -> AppInfo? {
        if let object = try modelContext.model(for: id) as? AppInfo {
            return object
        }
        
        return nil
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
