import SwiftUI

struct CardViewStyle: ViewModifier {
    var backgroundColor: Color
    
    var cornerRadius: CGFloat
    var borderColor: Color?
    var showShadow: Bool
    
    func body(content: Content) -> some View {
        content
            //.padding()
            .background(backgroundColor)
            .cornerRadius(cornerRadius)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(borderColor ?? .clear, lineWidth: 1.0)
                    
            )
            .if(showShadow) { content in
                content
                    .shadow(color: Color.black.opacity(0.1), radius: 6, x: 0, y: 0)
            }
    }
}

extension View {
    func cardViewStyle(backgroundColor: Color, cornerRadius: CGFloat = 20.0, borderColor: Color? = nil, showShadow: Bool = true) -> some View {
        self.modifier(CardViewStyle(backgroundColor: backgroundColor, cornerRadius: cornerRadius, borderColor: borderColor, showShadow: showShadow))
    }
}

