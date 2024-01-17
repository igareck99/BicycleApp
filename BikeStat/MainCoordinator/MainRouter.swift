import Foundation
import SwiftUI

// MARK: - MainRouterProtocol

protocol MainRouterProtocol: View {
    
    associatedtype Content: View

    var content: () -> Content { get }

    func onMainView(_ coordinator: MainCoordinatorProtocol)
    
    func onLoginView(_ coordinator: MainCoordinatorProtocol)
    
    func onMapView(_ coordinator: MainCoordinatorProtocol)
    
    func onTemplateListView(_ coordinator: MainCoordinatorProtocol)
    
    func onTemplateRideView(_ template: TemplateRouteEnum,
                            _ coordinator: MainCoordinatorProtocol)
    
    func resetPath()
}

struct MainRouter<
    Content: View,
    State: MainRouterStatable,
    Factory: ViewsBaseFactoryProtocol
>: View {

    // MARK: - Internal Properties

    @ObservedObject var state: State
    let factory: Factory.Type
    let content: () -> Content

    var body: some View {
        NavigationStack(path: $state.path) {
            content()
                .navigationDestination(
                    for: BaseContentLink.self,
                    destination: factory.makeContent
                )
        }
    }
}

// MARK: - MainRouter(MainRouterProtocol)

extension MainRouter: MainRouterProtocol {

    func onMainView(_ coordinator: MainCoordinatorProtocol) {
        state.path = NavigationPath()
        state.path.append(BaseContentLink.tabView(coordinator))
    }
    
    func onLoginView(_ coordinator: MainCoordinatorProtocol) {
        state.path.append(BaseContentLink.authState(coordinator))
    }
    
    func onMapView(_ coordinator: MainCoordinatorProtocol) {
        state.path.append(BaseContentLink.mapView(coordinator))
    }
    
    func onTemplateListView(_ coordinator: MainCoordinatorProtocol) {
        state.path.append(BaseContentLink.templateList(coordinator))
    }
    
    func onTemplateRideView(_ template: TemplateRouteEnum,
                            _ coordinator: MainCoordinatorProtocol) {
        state.path.append(BaseContentLink.templateRideView(coordinator, template))
    }
    
    func resetPath() {
        state.path = NavigationPath()
        print("slasklask  \(state.path)")
    }
}
