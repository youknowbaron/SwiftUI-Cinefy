//
//  MovieList.swift
//  Cinefy
//
//  Created by vobach on 24/05/2021.
//

import SwiftUI

struct MovieList: View {
    var data: [Movie]
    var onLoadmore: () -> Void
    
    init(_ data: [Movie], onLoadmore: @escaping () -> Void) {
        self.data = data
        self.onLoadmore = onLoadmore
    }
    
    var body: some View {
        List {
            ForEach(data) { movie in
                NavigationLink(destination: DetailMovieScreen(movie: movie)) {
                    MovieRow(movie: movie)
                }
            }
            if (!data.isEmpty) {
                Rectangle()
                    .foregroundColor(.clear)
                    .onAppear(perform: onLoadmore)
            }
            
        }
    }
}
