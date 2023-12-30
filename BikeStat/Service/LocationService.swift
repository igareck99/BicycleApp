import Foundation
import CoreLocation


class LocationService: NSObject, CLLocationManagerDelegate, ObservableObject {
    
    let locationManager = CLLocationManager()
    @Published var currentLocation = CLLocation(latitude: 0.0, longitude: 0.0)
    var dataSizePublisher: Published<CLLocation>.Publisher { $currentLocation }
    

    func requestRealTimeLocation() {
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }
    
    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }
    
    func getLocationAccessLevel() -> LocationAccessLevel {
        let status = locationManager.authorizationStatus
        debugPrint("requestLocationAccess: \(status)")
        let accessLevel = locationAccessLevel(from: status)
        return accessLevel
    }
    
    private func locationAccessLevel(from status: CLAuthorizationStatus) -> LocationAccessLevel {
        switch status {
        case .restricted:
            return .restricted
        case .notDetermined:
            return .notDetermined
        case .denied:
            return .denied
        case .authorizedAlways:
            return .authorizedAlways
        case .authorizedWhenInUse:
            return .authorizedWhenInUse
        @unknown default:
            return .notDetermined
        }
    }
    
    func locationManager(
        _ manager: CLLocationManager,
        didChangeAuthorization status: CLAuthorizationStatus
    ) {
        debugPrint(status)
    }

    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        if let location = locations.last {
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            // print("slasas \(location)")
            self.currentLocation = location
        }
    }

    func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: Error
    ) {
        debugPrint("Error  \(error)")
    }
}
