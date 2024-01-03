import SwiftUI
import MapKit

struct MapView: View {
    @StateObject var viewModel: MapViewModel
    
//    private var travelTime: String? {
//        guard let route else { return nil }
//        let formatter = DateComponentsFormatter()
//        formatter.unitsStyle = .abbreviated
//        formatter.allowedUnits = [.hour, .minute, .second]
//        return formatter.string(from: route.expectedTravelTime)
//    }

    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            Map(interactionModes: [.all]) {
                Marker("Start", coordinate: viewModel.startingPoint)
                Marker("End", coordinate: viewModel.endPoint)
                if let route = viewModel.route {
                    MapPolyline(route)
                        .stroke(.green, lineWidth: 4)
                }
            }
            .frame(height: UIScreen.main.bounds.width)
            labels
            Spacer()
        }
        .onAppear {
            viewModel.getDirections()
        }
    }
    
    private var labels: some View {
        VStack(spacing: 8) {
            ButtonView(title: viewModel.isStart ? "Завершить поездку" : "Начать", colors: [.blue, .blue]) {
                if viewModel.isStart {
                    viewModel.isStart.toggle()
                } else {
                    viewModel.computeResult()
                }
            }
        }
    }
}
