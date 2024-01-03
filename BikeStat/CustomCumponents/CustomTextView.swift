import SwiftUI

struct CurrencyView: View {
    private let width: CGFloat
    private let height: CGFloat
    
    let backgroundColor: Color
    let foregroundColor: Color
    var title: String
    
    init(width: CGFloat,
         height: CGFloat = 44,
         backgroundColor: Color,
         title: String,
         foregroundColor: Color = .white) {
        self.width = width
        self.height = height
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.title = title
    }
    
    var body: some View {
        HStack {
            Spacer()
            Text(title)
            Spacer()
        }.frame(width: 120, height: height)
            .background(backgroundColor)
            .cornerRadius(16)
            .overlay {
                RoundedRectangle(cornerRadius: 16)
                    .stroke(lineWidth: 2.5)
            }
    }
}

#Preview {
    CurrencyView(width: UIScreen.main.bounds.width - 60, height: 54, backgroundColor: .white,
                 title: "00:05", foregroundColor: .white)
}
