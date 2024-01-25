import SwiftUI

// MARK: - MainView

struct MainView: View {
    
    @StateObject var viewModel: MainViewModel
    
    // MARK: - Body
    
    var body: some View {
        content
    }
    
    private var content: some View {
        TabView {
            RideViewAssembly.build(viewModel.coordinator)
                .tabItem {
                    Label("Поездка", systemImage: "bicycle")
                }
            HistoryAssembly.build()
                .tabItem {
                    Label("История", systemImage: "list.clipboard")
                }
                .navigationBarTitleDisplayMode(.inline)   
            ChartsViewAssembly.build()
                .tabItem {
                    Label("Статистика", systemImage: "chart.xyaxis.line")
                }
        }
        .toolbar(.visible, for: .navigationBar)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
    }
}
