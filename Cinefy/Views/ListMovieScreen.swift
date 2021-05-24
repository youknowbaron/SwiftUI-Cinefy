//
//  ListMovieScreen.swift
//  Cinefy
//
//  Created by vobach on 24/05/2021.
//

import SwiftUI

struct ListMovieScreen: View {
    
    @StateObject private var viewModel = ListMovieViewModel(apiService: APIServiceImpl())
    
    @State var currentTab: Tab = .nowPlaying
    
    init(initPage: Int) {
        switch initPage {
        case 0:
            currentTab = .nowPlaying
            break
        case 1:
            currentTab = .upcoming
            break
        default:
            break
        }
    }
    
    enum Tab {
        case nowPlaying, upcoming
        
        var title: String {
            switch self {
            case .nowPlaying:
                return "Now Playing"
            case .upcoming:
                return "Upcoming"
            }
        }
    }
    
    var body: some View {
        Group {
            switch viewModel.state {
            case .loading:
                loadingView
            case .success(_):
                TabView(selection: $currentTab) {
                    
                    MovieList(viewModel.nowPlayingMovies) {
                        viewModel.loadNowPlayingMovies()
                    }
                    .tag(Tab.nowPlaying)
                    
                    MovieList(viewModel.upcomingMovies) {
                        viewModel.loadUpcomingMovies()
                    }
                    .tag(Tab.upcoming)
                    
                }
                .tabViewStyle(PageTabViewStyle())
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            case .failed(_):
                Text("Empty")
            }
        }
        .navigationBarTitle(currentTab.title, displayMode: .inline)
        .onAppear {
            if viewModel.nowPlayingMovies.isEmpty {
                viewModel.loadNowPlayingMovies()
            }
            if viewModel.upcomingMovies.isEmpty {
                viewModel.loadUpcomingMovies()
            }
        }
    }
    
    var loadingView: some View {
        List {
            ForEach(0..<2) { _ in
                ShimmerMovieRow()
            }
        }
    }
}
