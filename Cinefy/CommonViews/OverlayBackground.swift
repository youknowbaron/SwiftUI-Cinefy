//
//  OverlayBackground.swift
//  Cinefy
//
//  Created by vobach on 14/05/2021.
//

import SwiftUI

struct OverlayBackground: ViewModifier {
    
    func body(content: Content) -> some View {
        Group {
            content
        }
        .background(Color.overlayColor)
        .cornerRadius(25)
    }
    
}

extension View {
    func overlyfy() -> some View {
        self.modifier(OverlayBackground())
    }
}
