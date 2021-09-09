//
//  GeoFilteredLocations.swift
//  fjs
//
//  Created by Dan Ackerman on 9/8/21.
//

import Foundation
import SwiftUI
import CoreData

//get locations within 10 miles

class GeoFilteredLocations {

    public func getLocationsWithin10Miles(pointOfInterest: CLLocationCoordinate2D) {

        let D: Double = 16093.4 * 1.1
        let R: Double = 6371009
        let meanLatitidue = pointOfInterest.latitude * .pi / 180
        let deltaLatitude = D / R * 180 / .pi
        let deltaLongitude = D / (R * cos(meanLatitidue)) * 180 / .pi
        let minLatitude: Double = pointOfInterest.latitude - deltaLatitude
        let maxLatitude: Double = pointOfInterest.latitude + deltaLatitude
        let minLongitude: Double = pointOfInterest.longitude - deltaLongitude
        let maxLongitude: Double = pointOfInterest.longitude + deltaLongitude
//       NSPredicate(format: "(%lf <= longitude) AND (longitude <= %lf) AND (%lf <= latitude) AND (latitude <= %lf)", minLongitude, maxLongitude,minLatitude, maxLatitude)
        //           predicate: NSPredicate(format: "(%@ <= Location.longitude)", maxLongitude)

        
        let latitudeMinPredicate = NSPredicate(format: "latitude >= %lf", minLatitude)
        let latitudeMaxPredicate = NSPredicate(format: "latitude <= %lf", maxLatitude)
        let longitudeMinPredicate = NSPredicate(format: "longitude >= %lf", minLongitude)
        let longitudeMaxPredicate = NSPredicate(format: "longitude <= %lf", maxLongitude)

        var compoundPredicate = NSCompoundPredicate()
        compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [latitudeMinPredicate,latitudeMaxPredicate,longitudeMinPredicate, longitudeMaxPredicate])
//        fetchRequest.predicate = compoundPredicate

        
//        @FetchRequest(
//            entity: Location.entity(),
//            sortDescriptors: [],
//            predicate: latitudeMinPredicate
//        ) var nearbyLocations: FetchedResults<Location>
//
       // return NSPredicate(format: "\(lhs.path) == %@", argumentArray: [rhs])
//    }
            
//        @FetchRequest var filteredItems: FetchedResults<Location>
//        init(filter: String) {
//                _filteredItems = FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "title BEGINSWITH %@", filter))
//        }
//
        
        //this gets the list
          @FetchRequest var nearbyLocations: FetchedResults<Location>
          
          init(lodgeId: Int) {
            self._nearbyLocations = FetchRequest<NSFetchRequestResult>(
                  entity: Location.entity(),
                  sortDescriptors: [],
                  predicate: NSPredicate(format: "lodgeid == \(lodgeId)")
              )
          }

    }
}
