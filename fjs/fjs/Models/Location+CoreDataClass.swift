//
//  Location+CoreDataClass.swift
//  fjs
//
//  Created by Dan Ackerman on 9/6/21.
//
//

import Foundation
import CoreData

@objc(Location)
public class Location: NSManagedObject {

}

struct LocationModel: Decodable {
    var latitude: Double
    var longitude: Double
    var storeNo: Double
  
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        storeNo = try values.decode(Double.self, forKey: .storeNo)
        latitude = try values.decode(Double.self, forKey: .latitude)
        longitude = try values.decode(Double.self, forKey: .longitude)
    }
    
    enum CodingKeys: String, CodingKey {
        case latitude = "Latitude"
        case longitude = "Longitude"
        case storeNo = "StoreNo"
    }
}
