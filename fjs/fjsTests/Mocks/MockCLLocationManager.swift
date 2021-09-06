//
//  MockCLLocationManager.swift
//  fjsTests
//
//  Created by Dan Ackerman on 9/6/21.
//

import Foundation
import CoreLocation

class MockCLLocationManager: CLLocationManager {
    var mockLocation: CLLocation = CLLocation(latitude: 0, longitude: 0)
    override var location: CLLocation? {
        return mockLocation
    }
    override init() {
        super.init()
    }

    override func requestLocation() {
        self.delegate?.locationManager?(self, didUpdateLocations: [mockLocation])
    }
    
    func getAuthorizationStatus() -> CLAuthorizationStatus {
        return .authorizedWhenInUse
    }

    func isLocationServicesEnabled() -> Bool {
        return true
    }
}
