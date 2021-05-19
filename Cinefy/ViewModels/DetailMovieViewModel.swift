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
    
    @Published private(set) var detailMovie: Movie
    @Published private(set) var cast: [Cast] = []
    @Published private(set) var reviews: [Review] = []
    @Published private(set) var recommendations: [Movie] = []
    @Published private(set) var similar: [Movie] = []
    
    init(apiService: APIService, movie: Movie) {
        self.apiService = apiService
        self.detailMovie = movie
    }
    
    deinit {
        cancellables.forEach { cancellable in cancellable.cancel() }
    }
    
    func getDetailMovie(id: Int) {
        let cancellable = apiService.request(.getMovieDetail(id), dataType: Movie.self)
            .sink { status in
                switch status {
                case .finished:
                    print("Loaded detail of movie #\(id) successfully")
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
    
    func getCast(id: Int) {
        let cancellable = apiService.request(.getCredits(movieId: id), dataType: CreditsResponse.self)
            .sink { status in
                switch status {
                case .finished:
                    print("Loaded cast of movie #\(id) successfully")
                    break
                case .failure(let error):
                    print("Error: \(error)")
                    break
                }
            } receiveValue: { value in
                var sortedCast = value.cast
                    .filter { cast in cast.profilePath != nil }
                    .sorted { cast1, cast2 -> Bool in
                        cast1.popularity > cast2.popularity
                    }
                if sortedCast.count > 5 {
                    sortedCast.removeLast(sortedCast.count - 5)
                }
                self.cast = sortedCast
            }
        cancellables.insert(cancellable)
    }
    
    func getReviews(id: Int) {
        let cancellable = apiService.request(.getReviews(movieId: id), dataType: ReviewsResponse.self)
            .sink { status in
                switch status {
                case .finished:
                    print("Loaded reviews of movie #\(id) successfully")
                    break
                case .failure(let error):
                    print("Error: \(error)")
                    break
                }
            } receiveValue: { value in
                self.reviews = value.results
            }
        cancellables.insert(cancellable)
    }
    
    func getRecommendation(id: Int) {
        let cancellable = apiService.request(.getRecommendations(movieId: id), dataType: MoviesResponse.self)
            .sink { status in
                switch status {
                case .finished:
                    print("Loaded recommendations of movie #\(id) successfully")
                    break
                case .failure(let error):
                    print("Error: \(error)")
                    break
                }
            } receiveValue: { value in
                self.recommendations = value.results
            }
        cancellables.insert(cancellable)
    }
    
    func getSimilar(id: Int) {
        let cancellable = apiService.request(.getRecommendations(movieId: id), dataType: MoviesResponse.self)
            .sink { status in
                switch status {
                case .finished:
                    print("Loaded similar of movie #\(id) successfully")
                    break
                case .failure(let error):
                    print("Error: \(error)")
                    break
                }
            } receiveValue: { value in
                self.similar = value.results
            }
        cancellables.insert(cancellable)
    }
}
