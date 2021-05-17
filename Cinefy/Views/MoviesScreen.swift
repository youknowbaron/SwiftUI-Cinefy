//
//  MoviesScreen.swift
//  Cinefy
//
//  Created by vobach on 13/05/2021.
//

import SwiftUI

struct MoviesScreen: View {
    
    @ObservedObject var viewModel = MovieViewModel(apiService: APIServiceImpl())
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.bgColor.ignoresSafeArea()
                
                VStack {
                    
                    HStack {
                        
                        Spacer()
                    
                        Text("Now playing")
                            .font(.system(size: 20, weight: .semibold))
                        
                        Spacer()
                        
                        Image(systemName: "arrow.uturn.right")
                            .padding()
                            .onTapGesture {
                                presentationMode.wrappedValue.dismiss()
                            }
                        
                    }
                    
                    ScrollView {
                        ForEach(viewModel.movies) {movie in
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
            viewModel.getMovie()
        }
    }
}

//struct MoviesScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        MoviesScreen()
//    }
//}
