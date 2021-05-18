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
                        
                        Image("logo_cinefy")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100)
                            .padding(.leading, 20)
                        
                        Spacer()
                        
                        Image(systemName: "magnifyingglass")
                            .padding()
                            .onTapGesture {
                                
                            }
                        
                        Image(systemName: "arrow.uturn.right")
                            .padding()
                            .onTapGesture {
                                presentationMode.wrappedValue.dismiss()
                            }
                        
                    }
                    TabView {
                        MoviesListView(movies: viewModel.movies)
                        MoviesListView(movies: viewModel.movies)
                        MoviesListView(movies: viewModel.movies)
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    .ignoresSafeArea()
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
