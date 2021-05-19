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
        self.apiService = apiService
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
    }
    
    var orderNumberOfPopularMovie: Int {
       popularMovies.firstIndex(matching: popularMovie!)! + 1
    }
    
    func startTimer() {
        timer = Timer.publish(every: 10, on: .main, in: .common)
            .autoconnect()
        print("Start timer \(timer)")
    }

    func cancelTimer() {
        timer.upstream.connect().cancel()
        print("Cancel timer \(timer)")
    }
}
