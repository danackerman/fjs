//
//  Location+CoreDataProperties.swift
//  fjs
//
//  Created by Dan Ackerman on 9/6/21.
//
//

import Foundation
import CoreData


extension Location {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Location> {
        return NSFetchRequest<Location>(entityName: "Location")
    }

    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var storeNo: Double
}

extension Location : Identifiable {

}
