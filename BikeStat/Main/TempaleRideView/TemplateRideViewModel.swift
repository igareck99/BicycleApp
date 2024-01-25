import Foundation
import MapKit
import Combine

// MARK: - TemplateRideViewModel

final class TemplateRideViewModel: ObservableObject {
    
    let data: TemplateRouteEnum
    var coordinator: MainCoordinatorProtocol
    let locationService: LocationService
    let realmService: RealmServiceProtocol
    let requestService: RequestService
    @Published var isStart = false
    @Published var array: [CLLocationCoordinate2D] = []
    private var subscriptions = Set<AnyCancellable>()
    @Published var currentPosition = CLLocationCoordinate2D(
        latitude: 0.0,
        longitude: 0.0
    )
    @Published var route: MKRoute?
    @Published var distance = 0.0
    @Published var timeString = "00:00"
    @Published var speedString = "0"
    private var pulse: Pulse?
    private var totalSpeed = CLLocationSpeed(0)
    private var counts: Int = 0
    private var timeSeconds: TimeInterval = 0
    private var mediumSpeed = 0.0
    private var startTime: Date = Date()
    private var step = 0
    
    init(data: TemplateRouteEnum,
         coordinator: MainCoordinatorProtocol,
         requestService: RequestService = RequestService(),
         realmService: RealmServiceProtocol = RealmService.shared,
         locationService: LocationService = LocationService.shared) {
        self.data = data
        self.coordinator = coordinator
        self.locationService = locationService
        self.realmService = realmService
        self.requestService = requestService
        self.getDirections()
        self.bindInput()
    }
    
    deinit {
        subscriptions.removeAll()
    }
    
    func getDirections() {
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: data.startPoint ))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: data.endPoint))
        request.transportType = .automobile
        request.tollPreference = .any
        let directions = MKDirections(request: request)
        directions.calculate { response, error in
            guard let unwrappedResponse = response?.routes.first else { return }
            self.route = unwrappedResponse
            self.distance = 0
            self.array = self.route?.polyline.coordinates ?? []
            self.currentPosition = self.route?.polyline.coordinates.first ?? CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
        }
    }
    
    func performSteps() {
        let totalSteps = self.array.count - 1
        func performNextStep() {
            step += 1
            if step < totalSteps {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
                    guard let self = self else { return }
                    performNextStep()
                    self.currentPosition = self.array[self.step]
                    if self.step > 0 {
                        let speed = Double.random(in: 18.5...32.5)
                        self.speedString = String(format: "%.2f", speed)
                        self.totalSpeed += speed
                        self.computeDistance(self.array[self.step],
                                             self.array[self.step - 1])
                    }
                }
            }
        }
        performNextStep()
    }
    
    private func bindInput() {
        $isStart
            .subscribe(on: DispatchQueue.main)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                guard let self = self else { return }
                if value {
                    self.performSteps()
                    self.fire()
                }
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
        mediumSpeed = Double.random(in: 22.8...27.5)
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
    
}
