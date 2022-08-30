//
//  LocalImage+CoreDataProperties.swift
//  SwiftUIAppstoreSearch
//
//
//

import Foundation
import CoreData


extension LocalImage {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LocalImage> {
        return NSFetchRequest<LocalImage>(entityName: "LocalImage")
    }

    @NSManaged public var datetime: Date?
    @NSManaged public var url: String?

}

extension LocalImage : Identifiable {

}
