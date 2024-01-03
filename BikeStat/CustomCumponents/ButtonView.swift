import SwiftUI

// MARK: - ButtonView

struct ButtonView: View {
    
    let title: String
    let colors: [Color]
    var onTap: ()-> Void
    
    var body: some View {
        Button(action: {
            onTap()
        }, label: {
            Text(title)
                .frame(width: UIScreen.main.bounds.width - 64)
        })
        .padding()
        .foregroundColor(.white)
        .background(
            LinearGradient(gradient: Gradient(colors: colors),
                           startPoint: .topLeading, endPoint: .bottomTrailing)
        )
        .frame(idealWidth: UIScreen.main.bounds.width - 32)
        .cornerRadius(16)
    }
}
