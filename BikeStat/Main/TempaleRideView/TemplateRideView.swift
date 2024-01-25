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
                if let route = viewModel.route {
                    MapPolyline(route)
                        .stroke(.green, lineWidth: 4)
                }
                Annotation(
                    "",
                    coordinate: viewModel.currentPosition,
                    anchor: .bottom
                ) {
                    Image(systemName: "bicycle")
                        .padding(4)
                        .foregroundStyle(.blue)
                        .cornerRadius(4)
                }
            }
            .frame(height: UIScreen.main.bounds.width)
            labels
            Spacer()
        }
    }
    
    private var labels: some View {
        VStack(spacing: 12) {
            ButtonView(title: viewModel.isStart ? "Завершить поездку" : "Начать", colors: [.blue, .blue]) {
                if !viewModel.isStart {
                    viewModel.isStart.toggle()
                } else {
                    viewModel.isStart = false
                    viewModel.computeResult()
                }
            }
            HStack(spacing: 16) {
                CurrencyView(width: (UIScreen.main.bounds.width - 48) / 2,
                             height: 44, backgroundColor: .white,
                             title: viewModel.timeString,
                             foregroundColor: .black)
                CurrencyView(width: (UIScreen.main.bounds.width - 48) / 2,
                             height: 44, backgroundColor: .white,
                             title: viewModel.speedString + " км/ч",
                             foregroundColor: .black)
            }
            CurrencyView(width: (UIScreen.main.bounds.width - 48) / 2,
                         height: 44, backgroundColor: .white,
                         title: String(Int(viewModel.distance)) + " метров",
                         foregroundColor: .black)
        }
    }
}
