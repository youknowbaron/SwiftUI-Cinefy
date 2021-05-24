//
//  MoviesHorizontalListView.swift
//  Cinefy
//
//  Created by vobach on 18/05/2021.
//

import SwiftUI

struct MoviesHorizontalListView: View {
    
    var movies: [Movie]
    var isPopular: Bool = false
    var paramToViewMore: Int?
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 0) {
                
                ForEach(movies) { movie in
                    NavigationLink(destination: DetailMovieScreen(movie: movie)) {
                        MovieHorizontalItem(movie: movie, isPopular: isPopular)
                            .padding(.horizontal, 5)
                    }
                }
                
                if paramToViewMore != nil {
                    NavigationLink(destination: ListMovieScreen(initPage: paramToViewMore!)) {
                        Text("View more")
                            .multilineTextAlignment(.center)
                            .foregroundColor(.subTextColor)
                            .padding()
                    }
                }

            }
        }
    }
}

