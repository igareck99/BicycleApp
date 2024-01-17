import Foundation
import Combine

// MARK: - ChartsViewModel

final class ChartsViewModel: ObservableObject {
    
    let realmService: RealmServiceProtocol
    @Published var selectedColorIndex = 0
    @Published var rideData = 0
    @Published var displayData: [DisplayChartData] = []
    private var subscriptions = Set<AnyCancellable>()
    
    init(realmService: RealmServiceProtocol = RealmService.shared) {
        self.realmService = realmService
        self.getData()
    }
    
    func getDisplayItem(_ item: DisplayChartData) -> String {
        switch selectedColorIndex {
        case 0:
            return String(item.distance) + " m"
        case 1:
            return String(item.speed.rounded(.up))
        case 2:
            return item.dueation.hourMinuteSecond
        default:
            return ""
        }
    }
    
    private func getData() {
        displayData = self.realmService.getRideData().map {
            return DisplayChartData(distance: Int($0.distance), speed: $0.middleSpeed,
                                    time: $0.rideTime as NSDate, dueation: $0.duration)
        }
    }
}
