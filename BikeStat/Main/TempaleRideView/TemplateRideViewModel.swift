import Foundation
import MapKit
import Combine

// MARK: - TemplateRideViewModel

final class TemplateRideViewModel: ObservableObject {
    
    let data: TemplateRouteEnum
    var coordinator: MainCoordinatorProtocol
    let locationService: LocationService
    @Published var isStart = false
    private var subscriptions = Set<AnyCancellable>()
    
    init(data: TemplateRouteEnum,
         coordinator: MainCoordinatorProtocol,
         locationService: LocationService = LocationService.shared) {
        self.data = data
        self.coordinator = coordinator
        self.locationService = locationService
        self.getDirections()
        self.bindInput()
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
    
    private func bindInput() {
        $isStart
            .subscribe(on: DispatchQueue.main)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                guard let self = self else { return }
                if value {
                    print("slalsasl  \(self.data.startPoint)")
                    self.initLocation()
                }
            }
            .store(in: &subscriptions)
        locationService.dataSizePublisher
            .subscribe(on: DispatchQueue.global(qos: .userInitiated))
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                guard let self = self else { return }
                print("slalaslsal  \(value)")
                self.currentPosition = CLLocationCoordinate2D(latitude: value.coordinate.latitude,
                                                             longitude: value.coordinate.longitude)
//                if !self.isStart {
//                    return
//                }
//                self.counts += 1
//                self.totalSpeed += value.speed * 3.6
//                self.speed = value.speed * 3.6
//                self.speedString = String(format: "%.2f", self.speed)
            }
            .store(in: &subscriptions)
    }
    
    private func initLocation() {
        locationService.requestLocation()
    }
    
}
