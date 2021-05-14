//
//  SplashScreen.swift
//  Cinefy
//
//  Created by vobach on 12/05/2021.
//

import SwiftUI
import Lottie

struct SplashScreen: View {
    
    @State private var isAnimating = true
    
    var body: some View {
        VStack {
            
            LogoAnimatedView(isAnimating: $isAnimating)
                .frame(width: 200, height: 200)
            
            
            if !isAnimating {
                Text("onComplete animation")
            }
        }
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
