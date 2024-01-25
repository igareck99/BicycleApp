import Foundation
import _MapKit_SwiftUI
import Combine
import MapKit

final class MapViewModel: ObservableObject {
    
    let locationService: LocationService
    let requestService: RequestService
    let realmService: RealmServiceProtocol
    @Published var currentPosition = CLLocationCoordinate2D(
        latitude: 0.0,
        longitude: 0.0
    )
    @Published var route: MKRoute?
    @Published var distance = 0.0
    @Published var speed = CLLocationSpeed(0)
    @Published var isStart = false
    @Published var timeString = "00:00"
    @Published var speedString = "0"
    private var pulse: Pulse?
    private var totalSpeed = CLLocationSpeed(0)
    private var counts: Int = 0
    private var timeSeconds: TimeInterval = 0
    private var mediumSpeed = 0.0
    private var startTime: Date = Date()
    var coordinator: MainCoordinatorProtocol?
    private var subscriptions = Set<AnyCancellable>()
    
    init(locationService: LocationService = LocationService(),
         requestService: RequestService = RequestService(),
         realmService: RealmServiceProtocol = RealmService.shared) {
        self.locationService = locationService
        self.requestService = requestService
        self.realmService = realmService
        self.initLocation()
        self.bindInput()
    }
    
    func fire() {
        let timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { timer in
            if !self.isStart {
                return
            } else {
                self.timeSeconds += self.isStart ? timer.timeInterval : 0
                self.timeString =  self.timeSeconds.hourMinuteSecond
            }
        })
    }
    
    func computeResult() {
        getTechData()
        mediumSpeed = totalSpeed / Double(counts)
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
            if let pulse = pulse {
                let data = RideData(distance: distance, duration: timeSeconds, middleSpeed: mediumSpeed,
                                    minPulse: pulse.minValue, middlePulse: pulse.averageValue,
                                    maxPulse: pulse.maxValue, countedDiff: 1, realDiff: 1, startLongtitued: currentPosition.longitude, startLattitude: currentPosition.latitude, endLongtitude: currentPosition.longitude, endLattitude: currentPosition.latitude, rideTime: startTime)
                realmService.saveRideData(data)
            }
        }
    }
    
    private func bindInput() {
        $isStart
            .subscribe(on: DispatchQueue.main)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                if value {
                    self?.startTime = Date()
                    self?.fire()
                }
                
            }
            .store(in: &subscriptions)
        locationService.dataSizePublisher
            .subscribe(on: DispatchQueue.global(qos: .userInitiated))
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                guard let self = self else { return }
                if self.currentPosition.latitude == 0.0 && self.currentPosition.longitude == 0.0 {
                    
                } else {
                    self.computeDistance(self.currentPosition,
                                         value.coordinate)
                }
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
    
    private func computeDistance(_ coordinate1: CLLocationCoordinate2D,
                                 _ coordinate2: CLLocationCoordinate2D) {
        let coordinate1 = CLLocation(latitude: coordinate1.latitude, longitude: coordinate1.longitude)
        let coordinate2 = CLLocation(latitude: coordinate2.latitude, longitude: coordinate2.longitude)
        let distanceInMeters = coordinate1.distance(from: coordinate2)
        self.distance += distanceInMeters
    }
    
    private func initLocation() {
        locationService.requestLocation()
    }
}
