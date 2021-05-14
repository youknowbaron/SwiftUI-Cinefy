//
//  ColorExtension.swift
//  Cinefy
//
//  Created by vobach on 12/05/2021.
//

import SwiftUI

extension Color {
    
    static let bgColor = Color(0x17082A)
    static let textColor = Color.white
    static let subTextColor = Color.white.opacity(0.7)
    static let overlayColor = Color(0x210F37)
    static let buttonColor = Color(0x6644B8)
    static let highlightColor = Color(0xF79E44)
    
    init(_ hex: UInt32, opacity:Double = 1.0) {
        let red = Double((hex & 0xff0000) >> 16) / 255.0
        let green = Double((hex & 0xff00) >> 8) / 255.0
        let blue = Double((hex & 0xff) >> 0) / 255.0
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }
}
