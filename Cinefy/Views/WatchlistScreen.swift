//
//  WatchlistScreen.swift
//  Cinefy
//
//  Created by vobach on 21/05/2021.
//

import SwiftUI

struct WatchlistScreen: View {
    
    @StateObject private var viewModel = WatchlistViewModel(apiService: APIServiceImpl())
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.watchlistMovies) { movie in
                    NavigationLink(destination: DetailMovieScreen(movie: movie)) {
                        MovieRow(movie: movie)
                    }
                }
            }
            .navigationBarTitle("Watchlist")
            .onAppear {
                viewModel.getWatchlistMovies()
            }
        }
    }
}

