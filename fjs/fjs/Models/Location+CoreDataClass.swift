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
    var address: String?
    var addressTwo: String?
    var area: String?
    var city: String?
    var country: String?
    var interstate: String?
    var latitude: Double
    var longitude: Double
    var phone: String?
    var state: String?
    var storeFrontBrand: String?
    var storeName: String?
    var storeNo: Double
    var storeType: String?
    var zipCode: String?
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        address = try values.decode(String.self, forKey: .address)
        addressTwo = try values.decodeIfPresent(String.self, forKey: .addressTwo)
        area = try values.decodeIfPresent(String.self, forKey: .area)
        city = try values.decode(String.self, forKey: .city)
        country = try values.decode(String.self, forKey: .country)
        interstate = try values.decode(String.self, forKey: .interstate)
        latitude = try values.decode(Double.self, forKey: .latitude)
        longitude = try values.decode(Double.self, forKey: .longitude)
        phone = try values.decode(String.self, forKey: .phone)
        state = try values.decode(String.self, forKey: .state)
        storeFrontBrand = try values.decodeIfPresent(String.self, forKey: .storeFrontBrand)
        storeName = try values.decode(String.self, forKey: .storeName)
        storeNo = try values.decode(Double.self, forKey: .storeNo)
        storeType = try values.decodeIfPresent(String.self, forKey: .storeType)
        zipCode = try values.decodeIfPresent(String.self, forKey: .zipCode)
    }
    
    enum CodingKeys: String, CodingKey {
        case address = "Address"
        case addressTwo = "AddressTwo"
        case area = "Area"
        case city = "City"
        case country = "Country"
        case interstate = "Interstate"
        case latitude = "Latitude"
        case longitude = "Longitude"
        case phone = "Phone"
        case state = "State"
        case storeFrontBrand = "StoreFrontBrand"
        case storeName = "StoreName"
        case storeNo = "StoreNo"
        case storeType = "StoreType"
        case zipCode = "Zipcode"
        
    }
}
