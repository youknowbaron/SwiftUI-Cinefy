//
//  SearchScreen.swift
//  Cinefy
//
//  Created by vobach on 19/05/2021.
//

import SwiftUI

struct SearchScreen: View {
    
    @State private var query: String = ""
    
    @StateObject private var viewModel = SearchViewModel(apiService: APIServiceImpl())
    @State private var isSearching = false
    
    enum SearchFilter: Int {
        case movies, people
    }
    
    @State private var searchFilter = SearchFilter.movies
    
    var body: some View {
        
        List {
            SearchField(
                searchTextWrapper: viewModel,
                placeholder: "Search any movies or person",
                isSearching: $isSearching
            )
            .onPreferenceChange(OffsetTopPreferenceKey.self) { value in
                print("onPreferenceChange \(value)")
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
            
            Picker(selection: $searchFilter, label: Text("")) {
                Text("Movies").tag(SearchFilter.movies)
                Text("People").tag(SearchFilter.people)
            }
            .pickerStyle(SegmentedPickerStyle())
            
            ForEach(viewModel.searchedKeywords) { keyword in
                Text(keyword.name)
                    .padding(.vertical, 5)
                    .onTapGesture {
                        viewModel.searchText = keyword.name
                    }
            }
            
            if case .movies = searchFilter {
                ForEach(viewModel.searchedMovies) { movie in
                    NavigationLink(destination: DetailMovieScreen(movie: movie)) {
                        MovieRow(movie: movie)
                    }
                }
                .transition(.move(edge: .leading))
                .animation(.default)
            } else {
                ForEach(viewModel.people) { people in
                    NavigationLink(destination: DetailCastScreen(cast: people)) {
                        PeopleRow(cast: people)
                    }
                }
                .transition(.move(edge: .trailing))
                .animation(.default)
            }
            
        }
        .foregroundColor(.textColor)
        .navigationBarTitle("Search")
    }
}

struct SearchScreen_Previews: PreviewProvider {
    static var previews: some View {
        SearchScreen()
    }
}
