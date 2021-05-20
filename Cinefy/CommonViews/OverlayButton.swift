//
//  OverButton.swift
//  Cinefy
//
//  Created by vobach on 14/05/2021.
//

import SwiftUI

struct OverlayButton: ViewModifier {
    
    var backgroundColor: Color = .overlayColor
    var padding: CGFloat = 25
    
    func body(content: Content) -> some View {
        Group {
            content
        }
        .padding(padding)
        .background(backgroundColor)
        .cornerRadius(25)
    }
}

extension View {
    func buttify(backgroundColor: Color = .overlayColor, padding: CGFloat = 25) -> some View {
        self.modifier(OverlayButton(backgroundColor: backgroundColor, padding: padding))
    }
}
