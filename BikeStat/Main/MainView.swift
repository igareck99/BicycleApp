import SwiftUI

// MARK: - MainView

struct MainView: View {
    
    @StateObject var viewModel: MainViewModel
    
    // MARK: - Body
    
    var body: some View {
        content
            .toolbar(.hidden, for: .navigationBar)
    }
    
    private var content: some View {
        TabView {
            RideViewAssembly.build(viewModel.coordinator)
                .tabItem {
                    Label("Поездка", systemImage: "bicycle")
                }
            Text("История")
                .tabItem {
                    Label("История", systemImage: "list.clipboard")
                }
        }
    }
}
