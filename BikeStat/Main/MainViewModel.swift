import Foundation

// MARK: - MainViewModel

final class MainViewModel: ObservableObject {
    
    let requestService: RequestService
    var coordinator: MainCoordinatorProtocol?
    
    
    init(requestService: RequestService = RequestService.shared ) {
        self.requestService = requestService
    }
    
    func getTechData() {
        Task {
            let result = await requestService.getRequest("https://dt.miet.ru/ppo_it/api/watch/")
        }
    }
}
