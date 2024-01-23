//
//  URLCache+imageCache.swift
//  SwiftUIAppstoreSearch
//
//  Created by KAK KYOO LEE on 2024-01-09.
//

import Foundation

extension URLCache {
    static let imageCache = URLCache(memoryCapacity: 128_000_000, diskCapacity: 1_000_000_000)
}
