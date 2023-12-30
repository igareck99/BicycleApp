import SwiftUI

protocol MainRouterStatable: ObservableObject {
    var path: NavigationPath { get set }
}

// MARK: - ProfileRouterState

final class MainRouterState: MainRouterStatable {
    static var shared = MainRouterState()
    @Published var path = NavigationPath()
}
