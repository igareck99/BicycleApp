import Foundation

// MARK: - MainViewModel

final class MainViewModel: ObservableObject {
    
    let requestService: RequestService
    var coordinator: MainCoordinatorProtocol?
    
    
    init(requestService: RequestService = RequestService.shared ) {
        self.requestService = requestService
    }
}
