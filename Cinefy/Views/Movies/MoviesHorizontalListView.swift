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
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 0) {
                
                ForEach(movies) { movie in
                    NavigationLink(
                        destination: DetailMovieScreen(movie: movie)
                            .navigationBarTitle("")
                            .navigationBarHidden(true)
                    ) {
                        MovieHorizontalItem(movie: movie, isPopular: isPopular)
                            .padding(.horizontal, 5)
                    }
                }
            }
        }
    }
}

