import SwiftUI

protocol ViewsBaseFactoryProtocol {

    associatedtype Content: View

    @ViewBuilder
    static func makeContent(link: BaseContentLink) -> Content

}

enum ViewsBaseFactory: ViewsBaseFactoryProtocol {}

extension ViewsBaseFactory {
    @ViewBuilder
    static func makeContent(link: BaseContentLink) -> some View {
        switch link {
        case let .authState(coordinator):
            LoginViewAssembly.build(coordinator)
        case let .tabView(coordinator):
            MainViewAssembly.build(coordinator)
        }
    }
}
