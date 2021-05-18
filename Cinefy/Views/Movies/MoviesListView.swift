//
//  MoviesList.swift
//  Cinefy
//
//  Created by vobach on 17/05/2021.
//

import SwiftUI

struct MoviesListView: View {
    
    var movies: [Movie]
    
    var body: some View {
        ScrollView {
            ForEach(movies) {movie in
                NavigationLink(destination: DetailMovieScreen(movie: movie)) {
                    MovieItem(movie: movie)
                }
                .padding()
            }
        }
    }
}


