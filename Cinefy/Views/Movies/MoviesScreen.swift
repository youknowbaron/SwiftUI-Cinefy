//
//  MoviesScreen.swift
//  Cinefy
//
//  Created by vobach on 13/05/2021.
//

import SwiftUI

struct MoviesScreen: View {
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel = MovieViewModel(apiService: APIServiceImpl())
    @State var showLogInSheet = false
    
    @EnvironmentObject var userViewModel: UserViewModel
    
    var body: some View {
        NavigationView {
            Group {
                switch viewModel.state {
                case .loading:
                    loadingView
                case .success(_):
                    contentView
                case .failed(_):
                    Text("Error")
                }
            }
            .navigationBarTitle("")
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(
                leading: Image("logo_cinefy")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100),
                trailing: navigationBarTrailing
            )
            .foregroundColor(.textColor)
            
        }
        .onAppear {
            viewModel.getPopularMovies()
            viewModel.getNowPlayingMovies()
            viewModel.getUpcomingMovies()
        }
    }
    
    var navigationBarTrailing: some View {
        HStack {
            NavigationLink(destination: SearchScreen()) {
                Image(systemName: "magnifyingglass")
                    .padding()
            }
            
            if userViewModel.isLogin {
                NavigationLink(destination: AccountScreen {} ) {
                    avatar
                }
            } else {
                Button("Login") {
                    showLogInSheet = true
                }
                .sheet(isPresented: $showLogInSheet) {
                    LoginSheet { account in
                        print("Callback login success in MoviesScreen")
                    }
                    .environmentObject(userViewModel)
                }
            }
        }
        .foregroundColor(.textColor)
    }
    
    // MARK: Main view
    var contentView: some View {
        GeometryReader { geometry in
            
            let width = geometry.size.width
            
            ScrollView {
                
                VStack(alignment: .leading) {
                    
                    if let popularMovie = viewModel.popularMovie {
                        PopularHeaderView(viewModel: viewModel, movie: popularMovie, no: viewModel.orderNumberOfPopularMovie)
                            .frame(width: width, height: width * 3 / 2)
                            .onReceive(viewModel.timer) { time in
                                viewModel.changePopularMovie()
                            }
                            .animation(.linear)
                            .onAppear {
                                viewModel.startTimer()
                            }
                            .onDisappear {
                                viewModel.cancelTimer()
                            }
                        
                    }
                    
                    if !viewModel.nowPlayingMovies.isEmpty {
                        Text("Now Playing")
                            .font(.system(size: 20, weight: .bold))
                            .padding(.leading, 15)
                        
                        MoviesHorizontalListView(movies: viewModel.nowPlayingMovies, paramToViewMore: 0)
                    }
                    
                    if !viewModel.popularMovies.isEmpty {
                        Text("Popular Today")
                            .font(.system(size: 20, weight: .bold))
                            .padding([.leading, .top], 15)
                        
                        MoviesHorizontalListView(movies: viewModel.popularMovies, isPopular: true)
                    }
                    
                    if !viewModel.upcomingMovies.isEmpty {
                        Text("Upcoming")
                            .font(.system(size: 20, weight: .bold))
                            .padding([.leading, .top], 15)
                        
                        MoviesHorizontalListView(movies: viewModel.upcomingMovies, paramToViewMore: 1)
                    }
                }
                .padding(.bottom, 40)
            }
            .ignoresSafeArea(edges: .top)
        }
    }
    
    var loadingView: some View {
        VStack(alignment: .leading) {
            ForEach(0..<2) { _ in
                ShimmerMovieRow()
            }
            
            Spacer()
        }
        .padding()
    }
    
    var avatar: some View {
        AvatarView(url: userViewModel.account?.avatar.tmdb.avatarPath)
    }
    
}
