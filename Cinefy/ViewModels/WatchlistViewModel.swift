//
//  WatchlistViewModel.swift
//  Cinefy
//
//  Created by vobach on 21/05/2021.
//

import Foundation
import Combine

class WatchlistViewModel : ObservableObject {
    
    private var cancellables = Set<AnyCancellable>()
    private var apiService: APIService
    
    @Published private(set) var watchlistMovies: [Movie] = []
    @Published private(set) var state: ResultState<[Movie]> = .loading
    
    init(apiService: APIService) {
        self.apiService = apiService
    }
    
    deinit {
        cancellables.forEach { $0.cancel() }
    }
    
    func getWatchlistMovies() {
        guard UserState.isLogin else { return }
        let request = CinefyApi.getWatchlistMovies(
            accountId: UserState.account!.id,
            query: [APIKeys.SESSION_ID: UserState.sessionID!]
        )
        let cancellable = apiService.request(request, dataType: MoviesResponse.self)
            .sink { status in
                switch status {
                case .finished:
                    self.state = .success(data: self.watchlistMovies)
                case .failure(let error):
                    self.state = .failed(error: error)
                }
            } receiveValue: { value in
                self.watchlistMovies = value.results
            }
        cancellables.insert(cancellable)
    }
}
