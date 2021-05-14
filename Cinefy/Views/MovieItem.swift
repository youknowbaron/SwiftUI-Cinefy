//
//  MovieItem.swift
//  Cinefy
//
//  Created by vobach on 13/05/2021.
//

import SwiftUI
import URLImage

struct MovieItem: View {
    
    var movie: Movie
    
    var body: some View {
        let url = URL(string: "https://image.tmdb.org/t/p/w400\(movie.backdropPath)")!
        
        VStack(alignment: .leading, spacing: 10) {
            
//            URLImage(url) { image in
//
//            }
            
            URLImage(url, inProgress: { _ in PlaceholderImage()}) { image in
                image.resizable()
                    .cornerRadius(30)
                    .aspectRatio(2/1, contentMode: .fill)
            }
            
            Text(movie.title).font(.system(size: 20, weight: .medium))
                .foregroundColor(.textColor)
                .padding(.leading, 15)
            
            RatingView(movie.voteAverage)
                .padding(.leading, 15)
        }
        .frame(maxWidth: .infinity)
        .padding(.bottom, 15)
    }
}

//struct MovieItem_Previews: PreviewProvider {
//    static var previews: some View {
//        MovieItem()
//    }
//}
