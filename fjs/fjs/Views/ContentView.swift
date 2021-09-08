//
//  ContentView.swift
//  fjs
//
//  Created by Dan Ackerman on 9/6/21.
//

import SwiftUI
import MapKit
import CoreData

struct LocationAnnotation: Identifiable {
    let id = UUID()
    let storeNo: Double
    let coordinates: CLLocationCoordinate2D
}


struct LocationsMap: View {

    let currentLocation = LocationService.currentLocation
 
    @StateObject var persistenceController = PersistenceController.shared
        
    @State private var region = MKCoordinateRegion(
      center: CLLocationCoordinate2D(latitude: 40.2151, longitude: -82.8799),
        span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
    )
        
    var body: some View {
        Map(coordinateRegion: $region,
            interactionModes: [.all],
            showsUserLocation: true,
            //userTrackingMode: .constant(.follow),
            annotationItems: persistenceController.annotations
            ) {
                (location) -> MapPin in
                MapPin(coordinate: location.coordinates, tint: .red)
            
            // see notes in Readme about .OnTapGesture
        }
    }
}

struct ContentView: View {

    var body: some View {
        LocationsMap()
    }

}


struct ContentView_Previews: PreviewProvider {

    static var previews: some View {

        ContentView()
    }

}
