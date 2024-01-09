//
//  Features.swift
//  SwiftUIAppstoreSearch
//
//

import Foundation

struct Features: Decodable {
    let discovers: [String]
    let suggestedList: [AppModel]
}
