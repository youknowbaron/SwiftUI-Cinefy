//
//  MyButton.swift
//  Cinefy
//
//  Created by vobach on 14/05/2021.
//

import SwiftUI

struct MyButton: View {
    
    var text: String
    var horizontalMargin: CGFloat
    var action: () -> Void
    
    init(_ text: String,  horizontalMargin: CGFloat = 0, action: @escaping () -> Void) {
        self.text = text
        self.horizontalMargin = horizontalMargin
        self.action = action
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
