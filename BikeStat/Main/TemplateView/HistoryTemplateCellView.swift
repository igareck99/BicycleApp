import SwiftUI
import MapKit

struct HistoryTemplateCellView: View {
    
    @StateObject var viewModel: HistoryTemplateCellViewModel
    
    var body: some View {
        HStack(alignment: .center, spacing: 12, content: {
            Map(interactionModes: []) {
                Marker("", coordinate: viewModel.template.startPoint)
                Marker("", coordinate: viewModel.template.endPoint)
                if let route = viewModel.route {
                    MapPolyline(route)
                        .stroke(.green, lineWidth: 4)
                }
            }
            .frame(width: 150, height: 96)
            .cornerRadius(8)
            VStack(alignment: .leading,
                   spacing: 8) {
                Text("\(viewModel.distance)")
                Text("Длительность \(viewModel.time)")
                Text("Сложность \(viewModel.getLevel())")
            }
        })
        .background(content: {
            Color.white
        })
        .frame(height: 120)
    }
}
