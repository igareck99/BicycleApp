import Foundation
import MapKit

final class HistoryCellViewModel: ObservableObject {
 
    @Published var template: RideRealmData
    @Published var route: MKRoute?
    @Published var startPoint = CLLocationCoordinate2D(latitude: 0.0,
                                                        longitude: 0.0)
    @Published var endPoint = CLLocationCoordinate2D(latitude: 0.0,
                                                        longitude: 0.0)
    
    init(template: RideRealmData) {
        self.template = template
        self.getDirections()
    }
    
    func getLevel() -> String {
        if template.realDiff == 0 {
            return "Легкий"
        } else if template.realDiff == 1 {
            return "Средний"
        } else if template.realDiff  == 2 {
            return "Сложный"
        }
        return ""
    }
    
    func getCountableLevel() -> String {
        if template.countedDiff == 0 {
            return "Легкий"
        } else if template.countedDiff == 1 {
            return "Средний"
        } else if template.countedDiff  == 2 {
            return "Сложный"
        }
        return ""
    }
    
    func getDirections() {
        self.startPoint = CLLocationCoordinate2D(latitude: template.startLattitude,
                                                 longitude: template.startLongtitude)
        self.endPoint = CLLocationCoordinate2D(latitude: template.endLattitude,
                                                 longitude: template.endLongtitude)
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: template.startLattitude, longitude: template.startLongtitude)))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: template.endLattitude, longitude: template.endLongtitude)))
        request.transportType = .automobile
        let directions = MKDirections(request: request)
        directions.calculate { response, error in
            guard let unwrappedResponse = response?.routes.first else { return }
            self.route = unwrappedResponse
            return
        }
    }
}
