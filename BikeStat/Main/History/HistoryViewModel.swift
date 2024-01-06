import Foundation
import RealmSwift

// MARK: - HistoryViewModel

final class HistoryViewModel: ObservableObject {
    
    let realmService: RealmServiceProtocol
    @Published var rides: [RideRealmData] = []
    
    init(realmService: RealmServiceProtocol = RealmService.shared) {
        self.realmService = realmService
        self.initData()
    }
    
    private func initData() {
        self.rides = realmService.getRideData()
        
    }
}
