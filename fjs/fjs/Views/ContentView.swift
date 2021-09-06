//
//  ContentView.swift
//  fjs
//
//  Created by Dan Ackerman on 9/6/21.
//

import SwiftUI
import MapKit
//import CoreLocation

struct LocationsMap: View {

    let location = LocationService.currentLocation
    
    
    @State private var region = MKCoordinateRegion(
      center: CLLocationCoordinate2D(latitude: 40.2151, longitude: -82.8799),
        span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
    )
        
    var body: some View {
        Map(coordinateRegion: $region,
            interactionModes: [.all],
            showsUserLocation: true,
            userTrackingMode: .constant(.follow))
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
