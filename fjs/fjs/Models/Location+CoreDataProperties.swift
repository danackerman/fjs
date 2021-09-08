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

    @NSManaged public var address: String?
    @NSManaged public var addressTwo: String?
    @NSManaged public var area: String?
    @NSManaged public var city: String?
    @NSManaged public var country: String?
    @NSManaged public var interstate: String?
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var phone: String?
    @NSManaged public var state: String?
    @NSManaged public var storeFrontBrand: String?
    @NSManaged public var storeName: String?
    @NSManaged public var storeNo: Double
    @NSManaged public var storeType: String?
    @NSManaged public var zipCode: String?

}

extension Location : Identifiable {

}
