//
//  ListMovieViewModel.swift
//  Cinefy
//
//  Created by vobach on 24/05/2021.
//

import Foundation
import Combine

class ListMovieViewModel: ObservableObject {
    
    private var apiService: APIService
    private var cancellables = Set<AnyCancellable>()
    
    @Published private(set) var nowPlayingMovies: [Movie] = []
    @Published private(set) var upcomingMovies: [Movie] = []
    @Published private(set) var state: ResultState<Bool> = .loading
    
    private var nowPlayingPage: Int = 0 {
        didSet {
            getNowPlayingMovies()
        }
    }
    
    private var upcomingPage: Int = 0 {
        didSet {
            getUpcomingMovies()
        }
    }
    
    init(apiService: APIService) {
        self.apiService = apiService
    }
    
    deinit {
        cancellables.forEach { $0.cancel() }
    }
    
    func loadNowPlayingMovies() {
        nowPlayingPage += 1
    }
    
    private func getNowPlayingMovies() {
        let cancellable = apiService.request(.getNowPlayingMovies(query: [APIKeys.PAGE: "\(nowPlayingPage)"]), dataType: MoviesResponse.self)
            .sink { status in
                switch status {
                case .finished:
                    self.state = .success(data: true)
                    break
                case .failure(let error):
                    print("Error: \(error)")
                    self.state = .failed(error: error)
                    break
                }
            } receiveValue: { value in
                print("Now playing movies page of \(self.nowPlayingPage)")
                self.nowPlayingMovies.append(contentsOf: value.results)
            }
        cancellables.insert(cancellable)
    }
    
    func loadUpcomingMovies() {
        upcomingPage += 1
    }
    
    private func getUpcomingMovies() {
        let cancellable = apiService.request(.getUpcomingMovies(query: [APIKeys.PAGE: "\(upcomingPage)"]), dataType: MoviesResponse.self)
            .sink { status in
                switch status {
                case .finished:
                    self.state = .success(data: true)
                    break
                case .failure(let error):
                    print("Error: \(error)")
                    self.state = .failed(error: error)
                    break
                }
            } receiveValue: { value in
                print("Upcoming movies page of \(self.upcomingPage)")
                self.upcomingMovies.append(contentsOf: value.results)
            }
        cancellables.insert(cancellable)
    }
    
}
