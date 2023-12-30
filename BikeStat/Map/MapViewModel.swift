import Foundation
import Combine
import MapKit

final class MapViewModel: ObservableObject {
    
    var locationService = LocationService()
    @Published var startingPoint = CLLocationCoordinate2D(
        latitude: 40.83657722488077,
        longitude: 14.306896671048852
    )
    
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        self.initLocation()
        self.bindInput()
    }
    
    // MARK: - Private Methods
    
    private func bindInput() {
        locationService.dataSizePublisher
            .subscribe(on: DispatchQueue.global(qos: .userInitiated))
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                self?.startingPoint = CLLocationCoordinate2D(latitude: value.coordinate.latitude,
                                                             longitude: value.coordinate.longitude)
                print("slasklaskl  \(value)")
            }
            .store(in: &subscriptions)
    }
    
    private func initLocation() {
        locationService.requestRealTimeLocation()
    }
}
