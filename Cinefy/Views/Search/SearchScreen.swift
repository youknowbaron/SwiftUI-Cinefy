//
//  SearchScreen.swift
//  Cinefy
//
//  Created by vobach on 19/05/2021.
//

import SwiftUI

struct SearchScreen: View {
    
    @State private var query: String = ""
    
    @ObservedObject private var viewModel = SearchViewModel(apiService: APIServiceImpl())
    @State private var isSearching = false
    
    var body: some View {
        
        NavigationView {
            ZStack(alignment: .top) {
                Color.bgColor.ignoresSafeArea()
                
                VStack(alignment: .leading) {
                    SearchField(
                        searchTextWrapper: viewModel,
                        placeholder: "Search any movies or person",
                        isSearching: $isSearching
                    )
                    
                    ScrollView {
                        VStack(alignment: .leading) {
                            
                            ForEach(viewModel.searchedKeywords) { keyword in
                                Text(keyword.name)
                                    .padding(.vertical, 5)
                                    .padding(.horizontal, 15)
                                    .onTapGesture {
                                        viewModel.searchText = keyword.name
                                    }
                            }
                            
                            HStack {
                                Text("Movies")
                                    .font(.system(size: 16, weight: .medium))
                                    .padding(15)
                                
                                Spacer()
                            }
                            .background(Color.overlayColor)
                            
                            ForEach(viewModel.searchedMovies) { movie in
                                NavigationLink(destination: DetailMovieScreen(movie: movie)) {
                                    MovieRow(movie: movie)
                                        .padding(.horizontal, 15)
                                }
                            }
                        }
                        
                    }
                    
                    
                    
                }
            }
            .foregroundColor(.textColor)
            .navigationTitle("")
            .navigationBarHidden(true)
        }
    }
}

struct SearchScreen_Previews: PreviewProvider {
    static var previews: some View {
        SearchScreen()
    }
}
