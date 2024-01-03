import SwiftUI

struct RideView: View {
    
    @StateObject var viewModel: RideViewModel
    
    var body: some View {
        VStack(alignment: .center, spacing: 24, content: {
            ButtonView(title: "Шаблоны Поездок", colors: [.red, .green]) {
                viewModel.coordinator?.onTemplateListView()
            }
            ButtonView(title: "Свободный заезд", colors: [.red, .blue]) {
                viewModel.coordinator?.onMapView()
            }
        })
    }
}
