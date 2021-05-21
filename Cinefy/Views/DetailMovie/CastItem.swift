//
//  CastItem.swift
//  Cinefy
//
//  Created by vobach on 18/05/2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct CastItem: View {
    
    var cast: Cast
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 10) {
            WebImage(url: URL(string: cast.profilePath!.addImageUrl(quality: 300)))
                .resizable()
                .frame(width: 135, height: 180)
                .scaledToFill()
                .cornerRadius(10)
            
            Text(cast.name)
                .font(.system(size: 16, weight: .medium))
                .lineLimit(2)
            
            Text(cast.character!)
                .foregroundColor(.subTextColor)
                .lineLimit(2)
        }
        .frame(maxWidth: 140)
        
    }
}
