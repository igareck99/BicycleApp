import SwiftUI

protocol RootCoordinatable: ObservableObject {
    var controller: UIViewController { get }
}

final class AppCoordinator: RootCoordinatable {

    @Published var rootView: AnyView = Text("").anyView()
    var controller: UIViewController {
        hostController
    }
    lazy var hostController: UIHostingController = {
        UIHostingController(rootView: rootView)
    }()
    var childCoordinators: [String: Coordinator] = [:]
    private var pendingCoordinators = [Coordinator]()
    
    func makeLoginView() {
        let coordinator = MainCoordinatorAssembly.build { [weak self] view in
            guard let self = self else { return }
            self.rootView = view.anyView()
            hostController.rootView = self.rootView
        }
        addChildCoordinator(coordinator)
        coordinator.start()
    }
}

// MARK: - Coordinator

extension AppCoordinator: Coordinator {

    func start() {
        makeLoginView()
    }
}
