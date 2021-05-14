//
//  LogoAnimatedView.swift
//  Cinefy
//
//  Created by vobach on 12/05/2021.
//

import Lottie
import SwiftUI

struct LogoAnimatedView: UIViewRepresentable {
    
    @Binding var isAnimating: Bool
    
    func makeUIView(context: Context) -> AnimationView {
        let view = AnimationView(name: "cinema", bundle: .main)
        // onComplete
        view.play { status in
            if status {
                withAnimation(.interactiveSpring(response: 0.7, dampingFraction: 0.8, blendDuration: 0.8)) {
                    isAnimating.toggle()
                }
            }
        }
        
        return view
    }
    
    func updateUIView(_ uiView: AnimationView, context: Context) {
        
    }
}

