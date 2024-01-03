import Foundation
import _MapKit_SwiftUI
import Combine
import MapKit

final class MapViewModel: ObservableObject {
    
    var locationService = LocationService()
    var newlocationManager = NewLocationManager()
    @Published var startingPoint = CLLocationCoordinate2D(latitude: 55.96875954463992,
                                                          longitude: 37.13258993529138)
    @Published var endPoint = CLLocationCoordinate2D(latitude: 56.038462259893365,
                                                     longitude: 37.232012341263435)
    @Published var currentPosition = CLLocationCoordinate2D(
        latitude: 0.0,
        longitude: 0.0
    )
    @Published var route: MKRoute?
    @Published var distance = "0 метров"
    @Published var speed = CLLocationSpeed(0)
    @Published var isStart = false
    private var totalSpeed = CLLocationSpeed(0)
    private var counts: Int = 0
    var coordinator: MainCoordinatorProtocol?
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        self.initLocation()
        self.bindInput()
        self.fire()
    }
    
    func fire() {
        let timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { timer in
            print("Таймер!  \(timer.timeInterval)")
        })
    }
    
    func getDirections() {
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: startingPoint))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: endPoint))
        request.transportType = .walking
        request.tollPreference = .any
        let directions = MKDirections(request: request)
        directions.calculate { response, error in
            guard let unwrappedResponse = response?.routes.first else { return }
            self.route = unwrappedResponse
            self.distance = String(self.route?.distance ?? 0) + " метров"
        }
    }
    
    func computeResult() {
        print("totalSpeed  \(totalSpeed / Double(counts))")
    }
    
    // MARK: - Private Methods
    
    private func bindInput() {
        locationService.dataSizePublisher
            .subscribe(on: DispatchQueue.global(qos: .userInitiated))
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                guard let self = self else { return }
                self.currentPosition = CLLocationCoordinate2D(latitude: value.coordinate.latitude,
                                                             longitude: value.coordinate.longitude)
                self.counts += 1
                self.speed = self.speed
                
            }
            .store(in: &subscriptions)
    }
    
    private func initLocation() {
        locationService.requestLocation()
    }
}
