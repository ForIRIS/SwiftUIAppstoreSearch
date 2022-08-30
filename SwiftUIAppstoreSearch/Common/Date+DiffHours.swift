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

}
