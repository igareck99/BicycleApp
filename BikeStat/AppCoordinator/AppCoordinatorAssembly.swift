import Foundation

enum AppCoordinatorAssembly {
    static var coordinator: AppCoordinator = make()

    static func make() -> AppCoordinator {
        let coordinator = AppCoordinator()
        coordinator.start()
        return coordinator
    }
}
