import SwiftUI

// MARK: - MainCoordinatorAssembly

enum MainCoordinatorAssembly {
    static func build(
        renderView: @escaping (any View) -> Void
    ) -> Coordinator {
        let state = MainRouterState.shared
        let router = MainRouter(state: state,
                                factory: ViewsBaseFactory.self) {
            EmptyView()
        }
        let coordinator = MainCoordinator(router: router,
                                          renderView: renderView)
        return coordinator
    }
}
