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
    
    init(apiService: APIService) {
        self.apiService = apiService
    }
    
    deinit {
        cancellables.forEach { $0.cancel() }
    }
    
    func getWatchlistMovies() {
        guard UserState.isLogin else { return }
        let cancellable = apiService.request(.getWatchlistMovies(accountId: UserState.account!.id, sessionId: UserState.sessionID!), dataType: MoviesResponse.self)
            .sink { status in
                print(status)
            } receiveValue: { value in
                self.watchlistMovies = value.results
            }
        cancellables.insert(cancellable)
    }
}