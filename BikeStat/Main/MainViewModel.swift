import Foundation


final class MainViewModel: ObservableObject {
    
    let requestService: RequestService
    var coordinator: MainCoordinatorProtocol?
    
    
    init(requestService: RequestService = RequestService.shared ) {
        self.requestService = requestService
        self.getTechData()
    }
    
    func getTechData() {
        Task {
            let result = await requestService.getRequest("https://dt.miet.ru/ppo_it/api/watch/")
        }
    }
}
