//
//  MyButton.swift
//  Cinefy
//
//  Created by vobach on 14/05/2021.
//

import SwiftUI

struct MyButton: View {
    
    var text: String
    var action: () -> Void
    var horizontalMargin: CGFloat
    
    init(_ text: String, action: @escaping () -> Void, horizontalMargin: CGFloat = 0) {
        self.text = text
        self.action = action
        self.horizontalMargin = horizontalMargin
    }
    
    var body: some View {
        Button(action: action) {
            Text(text)
                .frame(maxWidth: .infinity)
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(.textColor)
                .padding()
        }
        .background(Color.buttonColor)
        .cornerRadius(20)
        .padding(.horizontal, horizontalMargin)
    }
}

struct MyButton_Previews: PreviewProvider {
    static var previews: some View {
        MyButton("Test") {}
    }
}
