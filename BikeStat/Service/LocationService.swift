import Foundation
import CoreLocation
import MapKit

class LocationService: NSObject, CLLocationManagerDelegate, ObservableObject {
    
    let locationManager = CLLocationManager()
    @Published var currentLocation = CLLocation(latitude: 0.0, longitude: 0.0)
    var dataSizePublisher: Published<CLLocation>.Publisher { $currentLocation }
    static let shared = LocationService()
    
    func requestLocation() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    
//    func stopUpdatingLocation() {
//        locationManager.stopUpdatingLocation()
//    }
    
    
    func locationManager(
        _ manager: CLLocationManager,
        didChangeAuthorization status: CLAuthorizationStatus
    ) {
        debugPrint("slkallaks  \(status)")
    }

    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        if let location = locations.last {
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            self.currentLocation = location
        }
    }

    func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: Error
    ) {
        debugPrint("Error in location  \(error)")
    }
}
