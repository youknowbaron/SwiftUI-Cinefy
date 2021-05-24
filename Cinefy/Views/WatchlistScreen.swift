//
//  WatchlistScreen.swift
//  Cinefy
//
//  Created by vobach on 21/05/2021.
//

import SwiftUI

struct WatchlistScreen: View {
    
    @StateObject private var viewModel = WatchlistViewModel(apiService: APIServiceImpl())
    @EnvironmentObject var userViewModel: UserViewModel
    
    var body: some View {
        NavigationView {
            List {
                if userViewModel.isLogin {
                    switch viewModel.state {
                    case .loading:
                        ForEach(0..<2) { _ in
                            ShimmerMovieRow()
                        }
                    case .success(_):
                        ForEach(viewModel.watchlistMovies) { movie in
                            NavigationLink(destination: DetailMovieScreen(movie: movie)) {
                                MovieRow(movie: movie)
                            }
                        }
                    case .failed(_):
                        Text("Empty")
                    }
                    
                } else {
                    AskToLoginView("Login to see your watchlist movies") { account in
                        viewModel.getWatchlistMovies()
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

