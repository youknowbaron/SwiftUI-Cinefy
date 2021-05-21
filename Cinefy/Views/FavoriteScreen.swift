//
//  FavoritesScreen.swift
//  Cinefy
//
//  Created by vobach on 21/05/2021.
//

import SwiftUI

struct FavoriteScreen: View {
    
    @StateObject private var viewModel = FavoriteViewModel(apiService: APIServiceImpl())
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.favoriteMovies) { movie in
                    NavigationLink(destination: DetailMovieScreen(movie: movie)) {
                        MovieRow(movie: movie)
                    }
                }
            }
            .navigationBarTitle("Favorites")
            .onAppear {
                viewModel.getFavoriteMovies()
            }
        }
    }
}
