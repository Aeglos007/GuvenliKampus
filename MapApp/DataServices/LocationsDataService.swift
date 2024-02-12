
//

import Foundation
import MapKit


class LocationsDataService {
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    
    func requestLocationPermission() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func getCurrentLocation() {
        locationManager.startUpdatingLocation()
        currentLocation = locationManager.location
    }
    
    static let locations: [Location] = [
        Location(
            name: "Acil Durum Çağrısı 1",
            coordinates: CLLocationCoordinate2D(latitude: 38.4624, longitude: 27.2192),
            imageNames: [
                "rome-colosseum-1",
                "rome-colosseum-2",
                "rome-colosseum-3",
            ]),
        Location(
            name: "Acil Durum Çağrısı 2",
            coordinates: CLLocationCoordinate2D(latitude: 38.4522264, longitude: 27.2322307),
            imageNames: [
                "rome-pantheon-1",
                "rome-pantheon-2",
                "rome-pantheon-3",
            ]),
        Location(
            name: "Acil Durum Çağrısı 3",
            coordinates: CLLocationCoordinate2D(latitude: 38.4624, longitude: 27.2192),
            imageNames: [
                "rome-trevifountain-1",
                "rome-trevifountain-2",
                "rome-trevifountain-3",
            ]),
        Location(
            name: "Acil Durum Çağrısı 4",
            coordinates: CLLocationCoordinate2D(latitude: 38.4580396, longitude: 27.2235189),
            imageNames: [
                "paris-eiffeltower-1",
                "paris-eiffeltower-2",
            ]),
        Location(
            name: "Acil Durum Çağrısı 5",
            coordinates: CLLocationCoordinate2D(latitude: 38.4578, longitude: 27.2105),
            imageNames: [
                "paris-louvre-1",
                "paris-louvre-2",
                "paris-louvre-3",
            ])
    ]
    
}
