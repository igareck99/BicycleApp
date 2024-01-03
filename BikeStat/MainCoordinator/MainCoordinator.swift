import SwiftUI

// MARK: - MainCoordinatorProtocol

protocol MainCoordinatorProtocol {
    
    func onMainTabScreen()
    
    func onLoginScreen()
}

// MARK: - MainCoordinator

final class MainCoordinator<Router: MainRouterProtocol>: Coordinator {
    var childCoordinators = [String: Coordinator]()
    private let router: Router
    let userDefaults: UserDefaults
    var renderView: (any View) -> Void

    // MARK: - Lifecycle

    init(router: Router,
         renderView: @escaping (any View) -> Void,
         userDefaults: UserDefaults = UserDefaults.standard) {
        self.router = router
        self.renderView = renderView
        self.userDefaults = userDefaults
        self.initData()
    }
    
    func start() {
        renderView(router)
    }
    
    // MARK: - Private Methods
    
    private func initData() {
        let value = UserDefaults.standard.bool(forKey: "isAuth")
        if value {
            self.onMainTabScreen()
        } else {
            self.onLoginScreen()
        }
    }
}

// MARK: - MainCoordinator(MainCoordinatorProtocol)

extension MainCoordinator: MainCoordinatorProtocol {

    func onMainTabScreen() {
        router.onMainView(self)
    }

    func onLoginScreen() {
        router.onLoginView(self)
    }
}
