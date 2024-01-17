import SwiftUI

// MARK: - MainCoordinatorAssembly

enum MainCoordinatorAssembly {
    static func build(
        renderView: @escaping (any View) -> Void
    ) -> Coordinator {
        let state = MainRouterState.shared
        let viewModel = MainViewModel()
        let view = MainView(viewModel: viewModel)
//        let viewModel = LoginViewModel()
//        let view = LoginView(viewModel: viewModel)
        let router = MainRouter(state: state,
                                factory: ViewsBaseFactory.self) {
            view
        }
        let coordinator = MainCoordinator(router: router,
                                          renderView: renderView)
        viewModel.coordinator = coordinator
        return coordinator
    }
}
