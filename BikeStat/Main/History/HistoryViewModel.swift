import Foundation

// MARK: - HistoryViewModel

final class HistoryViewModel: ObservableObject {
    
    let realmService: RealmServiceProtocol
    
    init(realmService: RealmServiceProtocol = RealmService.shared) {
        self.realmService = realmService
        self.initData()
    }
    
    private func initData() {
       print("slkalaskl  \(realmService.getRideData())")
    }
}
