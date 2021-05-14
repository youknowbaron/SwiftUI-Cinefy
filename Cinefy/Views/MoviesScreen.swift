//
//  MoviesScreen.swift
//  Cinefy
//
//  Created by vobach on 13/05/2021.
//

import SwiftUI

struct MoviesScreen: View {
    
    @ObservedObject var movieViewModel = MovieViewModel(apiService: APIServiceImpl())
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.bgColor.ignoresSafeArea()
                
                VStack {
                    
                    Text("Now playing")
                        .font(.system(size: 20, weight: .semibold))
                    
                    ScrollView {
                        
                        if movieViewModel.movies.count > 0 {
                            let movie = movieViewModel.movies[0]
                            NavigationLink(destination: DetailMovieScreen(movie: movie)) {
                                MovieItem(movie: movie)
                            }
                            .padding()
        
                        }
                    }
                    
                }
            }
            
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .foregroundColor(.textColor)
        }
        .onAppear {
            movieViewModel.getMovie()
        }
    }
}

//struct MoviesScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        MoviesScreen()
//    }
//}
