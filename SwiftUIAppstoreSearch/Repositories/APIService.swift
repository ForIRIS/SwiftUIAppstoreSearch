//
//  APIService.swift
//  SwiftUIAppstoreSearch
//
//

import Combine

protocol APIService {
    associatedtype T
    func run(with keyword: String) async throws -> T?
}
