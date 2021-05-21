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
    var isSmallUI: Bool
    var voteCount: Int?
    
    init(_ rating: Double, insertSpacer: Bool = false, isSmallUI: Bool = false, voteCount: Int? = nil) {
        self.rawRating = rating
        self.rating = Int(round(rating) / 2)
        self.insertSpacer = insertSpacer
        self.isSmallUI = isSmallUI
        self.voteCount = voteCount
    }
    
    var body: some View {

        return HStack(spacing: 5) {
            
            let size: CGFloat = isSmallUI ? 14.0 : 20.0
            
            ForEach(1..<6) { number in
                let color = number <= rating ? Color(0xF79E44) : Color(0x444F61)
                Image(systemName: "star.fill")
                    .frame(width: size, height: size)
                    .foregroundColor(color)
            }
            
            if insertSpacer {
                Spacer()
            }
            
            Text(voteCount != nil ? String(voteCount!) : String(rawRating))
                .foregroundColor(Color(0xF79E44))
                .padding(.leading, 5)
                .font(.system(size: size, weight: .semibold))
        }
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(7.8)
    }
}

