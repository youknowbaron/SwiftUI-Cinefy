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
    
    @Published private(set) var nowPlayingMovies: [Movie] = [Movie]()
    @Published private(set) var upcomingMovies: [Movie] = [Movie]()
    
    @Published private(set) var state: ResultState<[Movie]> = .loading
    
    @Published private(set) var popularMovies: [Movie] = [Movie]()
    @Published private(set) var popularMovie: Movie?
    
    private(set) var timer = Timer.publish(every: 10, on: .main, in: .common).autoconnect()
    
    init(apiService: APIService) {
        print("Init MoviesViewModel")
        self.apiService = apiService
    }
    
    deinit {
        print("Deinit MoviesViewModel")
        cancellables.forEach { $0.cancel() }
    }
    
    func getNowPlayingMovies() {
        let cancellable = apiService.request(.getNowPlayingMovies, dataType: MoviesResponse.self)
            .sink { status in
                switch status {
                case .finished:
                    self.state = .success(data: self.nowPlayingMovies)
                    print("Movies length: \(self.nowPlayingMovies.count)")
                    break
                case .failure(let error):
                    print("Error: \(error)")
                    self.state = .failed(error: error)
                    break
                }
            } receiveValue: { value in
                self.nowPlayingMovies = value.results
            }
        cancellables.insert(cancellable)
    }
    
    func getPopularMovies() {
        let cancellable = apiService.request(.getPopularMovies, dataType: MoviesResponse.self)
            .sink { status in
                switch status {
                case .finished:
                    print("Loaded popular movies successfully")
                    break
                case .failure(let error):
                    print("Error: \(error)")
                    self.state = .failed(error: error)
                    break
                }
            } receiveValue: { value in
                self.popularMovie = value.results.randomElement()
                self.popularMovies = value.results
                self.popularMovies.forEach { self.getMovieState(id: $0.id) }
            }
        cancellables.insert(cancellable)
    }
    
    func getUpcomingMovies() {
        let cancellable = apiService.request(.getUpcomingMovies, dataType: MoviesResponse.self)
            .sink { status in
                switch status {
                case .finished:
                    print("Loaded upcoming movies successfully")
                    break
                case .failure(let error):
                    print("Error: \(error)")
                    self.state = .failed(error: error)
                    break
                }
            } receiveValue: { value in
                self.upcomingMovies = value.results
            }
        cancellables.insert(cancellable)
    }
    
    func changePopularMovie() {
        popularMovie = popularMovies.randomElement()
//        if stateOfPopularMovies[popularMovie!.id] == nil {
//            getMovieState(id: popularMovie!.id)
//        }
    }
    
    var orderNumberOfPopularMovie: Int {
       popularMovies.firstIndex(matching: popularMovie!)! + 1
    }
    
    func startTimer() {
        timer = Timer.publish(every: 10, on: .main, in: .common)
            .autoconnect()
    }

    func cancelTimer() {
        timer.upstream.connect().cancel()
    }
    
    
    @Published private(set) var stateOfPopularMovies = [Int:Bool]()

    func isAdded2Watchlist(id: Int) -> Bool {
        stateOfPopularMovies[id] ?? false
    }
    
    func addToWatchlist(mediaType: String = "movie", mediaId: Int) {
        guard UserState.isLogin else { return }
        if stateOfPopularMovies[mediaId] != nil {
            stateOfPopularMovies[mediaId]!.toggle()
        } else {
            stateOfPopularMovies[mediaId] = true
        }
        let request = CinefyApi.addToWatchlist(
            accountId: UserState.account!.id,
            query: [CinefyApi.SESSION_ID_KEY: UserState.sessionID!],
            body: ["media_type": mediaType, "media_id": mediaId, "watchlist": stateOfPopularMovies[mediaId]!]
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
                self.stateOfPopularMovies[id] = value.watchlist
            }
        cancellables.insert(cancellable)
    }
}
