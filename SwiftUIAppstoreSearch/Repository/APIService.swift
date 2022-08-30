//
//  APIService.swift
//  SwiftUIAppstoreSearch
//
//

import Combine

protocol APIService {
    associatedtype T
    func searchBy(title: String) -> AnyPublisher<[T], Error>
}
