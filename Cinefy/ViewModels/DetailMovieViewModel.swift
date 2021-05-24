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
    
    @Published private(set) var detailMovie: Movie?
    @Published private(set) var cast: [Cast] = []
    @Published private(set) var reviews: [Review] = []
    @Published private(set) var recommendations: [Movie] = []
    @Published private(set) var similar: [Movie] = []
    
    @Published private(set) var isFavorited = false
    @Published private(set) var isAdded2Watchlist = false
    @Published private(set) var movieState: MovieState?
    
    init(apiService: APIService) {
        print("[init] DetailMovieViewModel")
        self.apiService = apiService
    }
    
    deinit {
        print("[deinit] DetailMovieViewModel")
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
                self.cast = value.cast
                    .filter { cast in cast.profilePath != nil }
                    .sorted { cast1, cast2 -> Bool in
                        cast1.popularity > cast2.popularity
                    }
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
    
    func markAsFavorite(mediaType: String = "movie", mediaId: Int) {
        guard UserState.isLogin else { return }
        self.isFavorited.toggle()
        let request = CinefyApi.markAsFavorite(
            accountId: UserState.account!.id,
            query: [CinefyApi.SESSION_ID_KEY: UserState.sessionID!],
            body: ["media_type": mediaType, "media_id": mediaId, "favorite": self.isFavorited]
        )
        let cancellable = apiService.request(request, dataType: MessageResponse.self)
            .sink { status in } receiveValue: { value in
                print("markAsFavorite \(value)")
            }
        cancellables.insert(cancellable)
    }
    
    
    func addToWatchlist(mediaType: String = "movie", mediaId: Int) {
        guard UserState.isLogin else { return }
        self.isAdded2Watchlist.toggle()
        let request = CinefyApi.addToWatchlist(
            accountId: UserState.account!.id,
            query: [CinefyApi.SESSION_ID_KEY: UserState.sessionID!],
            body: ["media_type": mediaType, "media_id": mediaId, "watchlist": self.isAdded2Watchlist]
        )
        let cancellable = apiService.request(request, dataType: MessageResponse.self)
            .sink { status in print(status) } receiveValue: { value in
                print("addToWatchlist \(value)")
            }
        cancellables.insert(cancellable)
    }
    
    func getMovieState(id: Int) {
        guard UserState.isLogin else { return }
        let request = CinefyApi.getMovieState(id: id, query: [CinefyApi.SESSION_ID_KEY: UserState.sessionID!])
        let cancellable = apiService.request(request, dataType: MovieState.self)
            .sink { status in
                print(status)
            } receiveValue: { value in
                self.isFavorited = value.favorite
                self.isAdded2Watchlist = value.watchlist
            }
        cancellables.insert(cancellable)
    }
}
