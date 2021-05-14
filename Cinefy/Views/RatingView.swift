//
//  RatingView.swift
//  Cinefy
//
//  Created by vobach on 13/05/2021.
//

import SwiftUI
import Foundation

struct RatingView: View {
    
    var rating: Int
    var rawRating: Double
    var insertSpacer: Bool
    
    init(_ rating: Double, insertSpacer: Bool = false) {
        self.rawRating = rating
        self.rating = Int(round(rating) / 2)
        self.insertSpacer = insertSpacer
    }
    
    var body: some View {

        return HStack(spacing: 5) {
            
            ForEach(1..<6) { number in
                let color = number <= rating ? Color(0xF79E44) : Color(0x444F61)
                Image(systemName: "star.fill")
                    .frame(width: 20, height: 20)
                    .foregroundColor(color)
            }
            
            if insertSpacer {
                Spacer()
            }
            
            Text(String(rawRating))
                .foregroundColor(Color(0xF79E44))
                .padding(.leading, 5)
                .font(.system(size: 20, weight: .semibold))
        }
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(7.8)
    }
}

