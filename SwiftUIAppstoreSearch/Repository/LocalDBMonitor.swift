//
//  LocalDBMonitor.swift
//  SwiftUIAppstoreSearch
//
//

import Foundation
import SwiftData
import Combine

@ModelActor
public actor LocalDBMonitor {
    private var cancellable: AnyCancellable?
}
