//
//  FavoriteViewModel.swift
//  Cinefy
//
//  Created by vobach on 21/05/2021.
//

import Foundation
import Combine

class FavoriteViewModel : ObservableObject {
    
    private var cancellables = Set<AnyCancellable>()
    private var apiService: APIService
    
    @Published private(set) var favoriteMovies: [Movie] = []
    
    init(apiService: APIService) {
        self.apiService = apiService
    }
    
    deinit {
        cancellables.forEach { $0.cancel() }
    }
    
    func getFavoriteMovies() {
        print("getFavoriteMovies isLogin: \(UserState.isLogin)")
        guard UserState.isLogin else { return }
        let cancellable = apiService.request(.getFavoriteMovies(accountId: UserState.account!.id, sessionId: UserState.sessionID!), dataType: MoviesResponse.self)
            .sink { status in
                print(status)
            } receiveValue: { value in
                self.favoriteMovies = value.results
            }
        cancellables.insert(cancellable)
    }
}
