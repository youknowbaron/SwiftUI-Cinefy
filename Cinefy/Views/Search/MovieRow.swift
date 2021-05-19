//
//  MovieRow.swift
//  Cinefy
//
//  Created by vobach on 19/05/2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct MovieRow: View {
    
    var movie: Movie
    
    var body: some View {
        HStack {
            if let posterPath = movie.posterPath {
                WebImage(url: URL(string: posterPath.addImageUrl()))
                    .resizable()
                    .frame(width: 100, height: 150)
                    .scaledToFill()
                    .cornerRadius(5)
                    .shadow(radius: 8)
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text(movie.title)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.textColor)
                    .lineLimit(2)
                RatingView(movie.popularity, isSmallUI: true)
                Text(movie.overview)
                    .foregroundColor(.subTextColor)
                    .lineLimit(3)
                    .truncationMode(.tail)
            }.padding(.leading, 8)
        }
        .padding(.top, 8)
        .padding(.bottom, 8)
    }
}
