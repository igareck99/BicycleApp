import Foundation
import MapKit

// MARK: - TemplateRideViewModel

final class TemplateRideViewModel: ObservableObject {
    
    let data: TemplateRouteEnum
    var coordinator: MainCoordinatorProtocol
    @Published var isStart = false
    
    init(data: TemplateRouteEnum, coordinator: MainCoordinatorProtocol) {
        self.data = data
        self.coordinator = coordinator
        self.getDirections()
    }
    @Published var currentPosition = CLLocationCoordinate2D(
        latitude: 0.0,
        longitude: 0.0
    )
    @Published var route: MKRoute?
    @Published var distance = "0 метров"
    
    func getDirections() {
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: data.startPoint ))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: data.endPoint))
        request.transportType = .walking
        request.tollPreference = .any
        let directions = MKDirections(request: request)
        directions.calculate { response, error in
            guard let unwrappedResponse = response?.routes.first else { return }
            self.route = unwrappedResponse
            self.distance = String(self.route?.distance ?? 0) + " метров"
        }
    }
}
