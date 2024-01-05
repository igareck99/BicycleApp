import Foundation
import _MapKit_SwiftUI
import Combine
import MapKit

final class MapViewModel: ObservableObject {
    
    let locationService: LocationService
    let requestService: RequestService
    @Published var currentPosition = CLLocationCoordinate2D(
        latitude: 0.0,
        longitude: 0.0
    )
    @Published var route: MKRoute?
    @Published var distance = "0 метров"
    @Published var speed = CLLocationSpeed(0)
    @Published var isStart = false
    @Published var timeString = "00:00"
    @Published var speedString = "0"
    private var pulse: Pulse?
    private var totalSpeed = CLLocationSpeed(0)
    private var counts: Int = 0
    private var timeSeconds: TimeInterval = 0
    var coordinator: MainCoordinatorProtocol?
    private var subscriptions = Set<AnyCancellable>()
    
    init(locationService: LocationService = LocationService(),
         requestService: RequestService = RequestService()) {
        self.locationService = locationService
        self.requestService = requestService
        self.initLocation()
        self.bindInput()
    }
    
    func fire() {
        let timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { timer in
            self.timeSeconds += timer.timeInterval
            self.timeString =  self.timeSeconds.hourMinuteSecond
        })
    }
    
    func computeResult() {
        getTechData()
    }
    
    // MARK: - Private Methods
    
    private func getTechData() {
        Task {
            let result = await requestService.getRequest("https://dt.miet.ru/ppo_it/api/watch/")
            guard let data = result?["data"] as? [String: Any] else { return }
            guard let p = data["pulse"] as? [String: Int] else { return }
            self.pulse = Pulse(minValue: p["min"] ?? 0,
                               averageValue: p["avg"] ?? 0,
                               maxValue: p["max"] ?? 0)
        }
    }
    
    private func bindInput() {
        $isStart
            .subscribe(on: DispatchQueue.main)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                if value {
                    self?.fire()
                }
                
            }
            .store(in: &subscriptions)
        locationService.dataSizePublisher
            .subscribe(on: DispatchQueue.global(qos: .userInitiated))
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                guard let self = self else { return }
                self.currentPosition = CLLocationCoordinate2D(latitude: value.coordinate.latitude,
                                                             longitude: value.coordinate.longitude)
                if !self.isStart {
                    return
                }
                self.counts += 1
                self.totalSpeed += value.speed * 3.6
                self.speed = value.speed * 3.6
                self.speedString = String(format: "%.2f", self.speed)
            }
            .store(in: &subscriptions)
    }
    
    private func initLocation() {
        locationService.requestLocation()
    }
}
