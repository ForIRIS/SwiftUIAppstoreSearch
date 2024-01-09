//
//  NetworkError.swift
//  SwiftUIAppstoreSearch
//
//

enum NetworkError: Error {
    case badUrl
    case invalidQueries
    case invalidRequest
    case badResponse
    case badStatus(Int)
    case failedToDecodeResponse
}
