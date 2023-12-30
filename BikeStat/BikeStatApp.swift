import SwiftUI

@main
struct BikeStatApp: App {
    @StateObject var rootCoordinator = AppCoordinatorAssembly.coordinator
    
    var body: some Scene {
        WindowGroup {
            rootCoordinator.rootView.anyView()
        }
    }
}
