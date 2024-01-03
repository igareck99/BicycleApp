import SwiftUI

struct TemplatesView: View {
    
    @StateObject var viewModel: TemplatesViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.items, id: \.self) { value in
                let vm = HistoryCellViewModel(template: value)
                HistoryCellView(viewModel: vm)
                    .onTapGesture {
                        viewModel.coordinator?.onTemplateListView(value)
                    }
            }
        }
        .listStyle(.inset)
    }
}
