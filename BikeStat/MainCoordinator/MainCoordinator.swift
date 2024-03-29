import SwiftUI

// MARK: - MainCoordinatorProtocol

protocol MainCoordinatorProtocol {
    
    func onMainTabScreen()
    
    func onLoginScreen()
    
    func onMapView()
    
    func onTemplateListView()
    
    func onTemplateListView(_ template: TemplateRouteEnum)
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
    }
    
    func start() {
        renderView(router)
    }
    
    // MARK: - Private Methods
    
    private func initData() {
//        let value = UserDefaults.standard.bool(forKey: "isAuth")
//        if value {
            self.onMainTabScreen()
//        } else {
//            self.onLoginScreen()
//        }
    }
}

// MARK: - MainCoordinator(MainCoordinatorProtocol)

extension MainCoordinator: MainCoordinatorProtocol {

    func onMainTabScreen() {
        router.resetPath()
        router.onMainView(self)
    }

    func onLoginScreen() {
        router.onLoginView(self)
    }
    
    func onMapView() {
        router.onMapView((self))
    }
    
    func onTemplateListView() {
        router.onTemplateListView((self))
    }
    
    func onTemplateListView(_ template: TemplateRouteEnum) {
        router.onTemplateRideView(template, self)
    }
}
