//
//  MoviesScreen.swift
//  Cinefy
//
//  Created by vobach on 13/05/2021.
//

import SwiftUI

struct MoviesScreen: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel = MovieViewModel(apiService: APIServiceImpl())
    
    var body: some View {
        
        NavigationView {
            
            GeometryReader { geometry in
                
                let width = geometry.size.width
                
                
                ScrollView {
                    
                    VStack(alignment: .leading) {
                        
                        if let popularMovie = viewModel.popularMovie {
                            PopularHeaderView(movie: popularMovie, no: viewModel.orderNumberOfPopularMovie)
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
                        
                        Text("Now Playing")
                            .font(.system(size: 20, weight: .bold))
                            .padding(.leading, 15)
                        
                        MoviesHorizontalListView(movies: viewModel.nowPlayingMovies)
                        
                        Text("Popular Today")
                            .font(.system(size: 20, weight: .bold))
                            .padding([.leading, .top], 15)
                        
                        MoviesHorizontalListView(movies: viewModel.popularMovies, isPopular: true)
                        
                        Text("Upcoming")
                            .font(.system(size: 20, weight: .bold))
                            .padding([.leading, .top], 15)
                        
                        MoviesHorizontalListView(movies: viewModel.upcomingMovies)
                    }
                    .padding(.bottom, 40)
                }
                .ignoresSafeArea(edges: .top)
                .navigationBarTitle("")
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(
                    leading: Image("logo_cinefy")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100),
                    trailing: HStack {
                        NavigationLink(destination: SearchScreen()) {
                            Image(systemName: "magnifyingglass")
                                .padding()
                        }
                        
                        Image(systemName: "arrow.uturn.right")
                            .padding()
                            .onTapGesture {
                                presentationMode.wrappedValue.dismiss()
                            }
                    }
                    .foregroundColor(.textColor)
                )
                .foregroundColor(.textColor)
            }
        }
        .onAppear {
            viewModel.getPopularMovies()
            viewModel.getNowPlayingMovies()
            viewModel.getUpcomingMovies()
        }
    }
}
