//
//  MovieHorizontalItem.swift
//  Cinefy
//
//  Created by vobach on 18/05/2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct MovieHorizontalItem: View {
    
    var movie: Movie
    var isPopular: Bool = false
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            
        WebImage(url: URL(string: movie.posterPath.addImageUrl(quality: 300)))
            .resizable()
            .scaledToFill()
            .frame(width: !isPopular ? 125 : 170, height: !isPopular ? 180 : 240)
            
            if isPopular {
                Top10Badge(top: 20)
            }
        }
        .cornerRadius(10)
    }
}

