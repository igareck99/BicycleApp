import SwiftUI
import MapKit

struct MapView: View {
    @StateObject var viewModel = MapViewModel()
    @State private var selectedResult: MKMapItem?
    @State private var route: MKRoute?
    
    private var travelTime: String? {
        guard let route else { return nil }
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .abbreviated
        formatter.allowedUnits = [.hour, .minute]
        return formatter.string(from: route.expectedTravelTime)
    }

    var body: some View {
        Map(selection: $selectedResult) {
            // Adding the marker for the starting point
            Marker("Start", coordinate: viewModel.startingPoint)
            
            // Show the route if it is available
            if let route {
                MapPolyline(route)
                    .stroke(.blue, lineWidth: 5)
            }
        }
        .onChange(of: selectedResult){
            getDirections()
        }
    }

    func getDirections() {
        self.route = nil
        
        // Check if there is a selected result
        guard let selectedResult else { return }
        viewModel.startingPoint = CLLocationCoordinate2D(
            latitude: 40.83657722488077,
            longitude: 14.306896671048852
        )
        
        // Create and configure the request
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: viewModel.startingPoint))
        request.destination = self.selectedResult
        
        // Get the directions based on the request
        Task {
            let directions = MKDirections(request: request)
            let response = try? await directions.calculate()
            route = response?.routes.first
        }
    }
}
