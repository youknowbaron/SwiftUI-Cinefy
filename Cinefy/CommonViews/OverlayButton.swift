//
//  OverButton.swift
//  Cinefy
//
//  Created by vobach on 14/05/2021.
//

import SwiftUI

struct OverlayButton: ViewModifier {
    
    func body(content: Content) -> some View {
        Group {
            content
        }
        .padding(25)
        .background(Color.overlayColor)
        .cornerRadius(25)
    }
}

extension View {
    func buttify() -> some View {
        self.modifier(OverlayButton())
    }
}
