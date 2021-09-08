//
//  LocationService.swift
//  fjs
//
//  Created by Dan Ackerman on 9/6/21.
//

import CoreLocation

class LocationService: NSObject, ObservableObject {
    
    static let shared = LocationService()
    
    static let DefaultLocation = CLLocationCoordinate2D(latitude: 40.2151, longitude: -82.8799)
  
    static var currentLocation: CLLocationCoordinate2D {
        guard let location = shared.locationManager.location else {
            return DefaultLocation
        }
        return location.coordinate
    }
    
    private let locationManager = CLLocationManager()
    
    private override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
}

extension LocationService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) { }
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location manager failed with error: \(error.localizedDescription)")
    }
    
    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("Location manager changed the status: \(status)")
    }
}
