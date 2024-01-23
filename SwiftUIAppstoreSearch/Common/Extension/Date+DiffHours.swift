//
//  Date+DiffHours.swift.swift
//  SwiftUIAppstoreSearch
//
//

import Foundation

extension Date {
    func diffHours(_ target: Date) -> Int {
        let ti = Int(self.timeIntervalSinceReferenceDate - target.timeIntervalSinceReferenceDate)
        
        return ti / 3600
    }

    func toISO8601String() -> String {
        let formatter = ISO8601DateFormatter()
        return formatter.string(from: self)
    }
}
