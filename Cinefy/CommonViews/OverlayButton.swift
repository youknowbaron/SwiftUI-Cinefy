//
//  OverButton.swift
//  Cinefy
//
//  Created by vobach on 14/05/2021.
//

import SwiftUI

struct OverlayButton: ViewModifier {
    
    var backgroundColor: Color = .overlayColor
    
    func body(content: Content) -> some View {
        Group {
            content
        }
        .padding(25)
        .background(backgroundColor)
        .cornerRadius(25)
    }
}

extension View {
    func buttify(backgroundColor: Color = .overlayColor) -> some View {
        self.modifier(OverlayButton(backgroundColor: backgroundColor))
    }
}
