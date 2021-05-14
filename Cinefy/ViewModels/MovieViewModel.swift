//
//  MovieViewModel.swift
//  Cinefy
//
//  Created by vobach on 13/05/2021.
//

import Foundation
import Combine

class MovieViewModel : ObservableObject {
    
    private let apiService: APIService
    
    private var cancellables = Set<AnyCancellable>()
    
    @Published private(set) var movies: [Movie] = [Movie]()
    @Published private(set) var state: ResultState<[Movie]> = .loading
    
    init(apiService: APIService) {
        self.apiService = apiService
    }
    
    func getMovie() {
        let cancellable = apiService.request(.getNowPlayingMovie, dataType: MoviesResponse.self)
            .sink { status in
                switch status {
                case .finished:
                    self.state = .success(data: self.movies)
                    print("Movies length: \(self.movies.count)")
                    break
                case .failure(let error):
                    print("Error: \(error)")
                    self.state = .failed(error: error)
                    break
                }
            } receiveValue: { value in
                self.movies = value.results
            }
        cancellables.insert(cancellable)
    }
    
}
