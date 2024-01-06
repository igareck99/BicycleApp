import Foundation
import _MapKit_SwiftUI
import MapKit

// MARK: - HistoryCellViewModel

final class HistoryTemplateCellViewModel: ObservableObject {
    
    @Published var template: TemplateRouteEnum
    @Published var route: MKRoute?
    @Published var distance: String
    @Published var time: String
    @Published var maxSpeed = 30
    @Published var middleSpeed = 26.5
    
    init(template: TemplateRouteEnum, route: MKRoute? = nil, distance: String = "0 метров", time: String = "0 c") {
        self.template = template
        self.route = route
        self.distance = distance
        self.time = time
        self.getDirections()
    }
    
    func getLevel() -> String {
        if template.level == 0 {
            return "Легкий"
        } else if template.level == 1 {
            return "Средний"
        } else if template.level  == 2 {
            return "Сложный"
        }
        return ""
    }
    
    func getDirections() {
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: template.startPoint))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: template.endPoint))
        request.transportType = .automobile
        let directions = MKDirections(request: request)
        directions.calculate { response, error in
            guard let unwrappedResponse = response?.routes.first else { return }
            self.route = unwrappedResponse
            self.distance = String(self.route?.distance ?? 0) + " метров"
            self.formatTime()
            return
        }
    }
    
    private func formatTime() {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
        formatter.allowedUnits = [.second, .minute, .hour]
        guard let pickedDate = self.route?.expectedTravelTime else { return }
        guard let formattedTimeLeft = formatter.string(from: pickedDate * 2) else { return }
        self.time = formattedTimeLeft
        if let s = self.route?.distance,
           let t = self.route?.expectedTravelTime {
            computeSpeed(s, t * 1.3)
        }
    }
    
    private func computeSpeed(_ distance: CLLocationDistance,
                              _ time: TimeInterval) {
        // print("slaslas  \((distance / time) * 3.6 )")
    }
}
