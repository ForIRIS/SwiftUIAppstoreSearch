//
//  APIService.swift
//  SwiftUIAppstoreSearch
//
//

import Combine

protocol APIService {
    associatedtype T
    func run(keyword: String) async throws -> T?
}
