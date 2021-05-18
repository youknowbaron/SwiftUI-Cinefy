//
//  MovieItem.swift
//  Cinefy
//
//  Created by vobach on 13/05/2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct MovieItem: View {
    
    var movie: Movie
    
    var body: some View {
        let url = URL(string: movie.backdropPath.addImageUrl())!
        
        VStack(alignment: .leading, spacing: 10) {
            
//            URLImage(url) { image in
//
//            }
            
            WebImage(url: url)
                .resizable()
                .cornerRadius(30)
                .aspectRatio(2/1, contentMode: .fill)
            
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
