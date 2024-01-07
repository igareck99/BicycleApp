import SwiftUI
import MapKit

// MARK: - TemplateRideView

struct TemplateRideView: View {
    
    @StateObject var viewModel: TemplateRideViewModel
    
    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            Map(interactionModes: [.all]) {
                Marker("Start", coordinate: viewModel.data.startPoint)
                Marker("End", coordinate: viewModel.data.endPoint)
                Annotation(
                    "Sign-in",
                    coordinate: viewModel.currentPosition,
                    anchor: .bottom
                ) {
                    Image(systemName: "bicycle")
                        .padding(4)
                        .foregroundStyle(.red)
                        .cornerRadius(4)
                }
                if let route = viewModel.route {
                    MapPolyline(route)
                        .stroke(.green, lineWidth: 4)
                }
            }
            .frame(height: UIScreen.main.bounds.width)
            labels
            Spacer()
        }
    }
    
    private var labels: some View {
        VStack(spacing: 8) {
            ButtonView(title: viewModel.isStart ? "Завершить поездку" : "Начать", colors: [.blue, .blue]) {
                if !viewModel.isStart {
                    viewModel.isStart = true
                } else {
                    
                }
            }
        }
    }
}
