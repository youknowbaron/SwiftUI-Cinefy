//
//  MovieViewModel.swift
//  Cinefy
//
//  Created by vobach on 13/05/2021.
//

import Foundation
import Combine

class DetailMovieViewModel : ObservableObject {
    
    private let apiService: APIService
    
    private var cancellables = Set<AnyCancellable>()
    
    @Published private(set) var state: ResultState<Movie> = .loading
    
    @Published var detailMovie: Movie
    
    init(apiService: APIService, movie: Movie) {
        self.apiService = apiService
        self.detailMovie = movie
    }
    
    func getDetailMovie(id: Int) {
        let cancellable = apiService.request(.getMovieDetail(id), dataType: Movie.self)
            .sink { status in
                switch status {
                case .finished:
                    print("Loading detail of movie #\(id) successfully")
                    break
                case .failure(let error):
                    print("Error: \(error)")
                    break
                }
            } receiveValue: { value in
                self.detailMovie = value
            }
        cancellables.insert(cancellable)
    }
}
