//
//  SearchTextObservable.swift
//  Cinefy
//
//  Created by vobach on 19/05/2021.
//

import SwiftUI
import Combine

class SearchViewModel: ObservableObject {
    
    private var apiService: APIService
    private var cancellables = Set<AnyCancellable>()
    
    @Published var searchText = "" {
        willSet {
            DispatchQueue.main.async {
                self.searchSubject.send(newValue)
            }
        }
        didSet {
            DispatchQueue.main.async {
                self.onUpdateText(text: self.searchText)
            }
        }
    }
    
    @Published private(set) var searchedKeywords: [Keyword] = []
    @Published private(set) var searchedMovies: [Movie] = []
    @Published private(set) var people: [Cast] = []
//    @Published private(set) var searchedPeople: []
        
    let searchSubject = PassthroughSubject<String, Never>()
    
    private var searchCancellable: Cancellable? {
        didSet {
            oldValue?.cancel()
        }
    }
    
    init(apiService: APIService) {
        self.apiService = apiService
        searchCancellable = searchSubject.eraseToAnyPublisher()
            .map { $0 }
            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .filter { !$0.isEmpty }
            .sink(receiveValue: { (searchText) in
                print("Search Text: \(searchText)")
                self.onUpdateTextDebounced(text: searchText)
            })
    }
    
    func onUpdateText(text: String) {
        
    }
    
    private func onUpdateTextDebounced(text: String) {
        let keywordRequest = CinefyApi.searchKeyword(
            query: [APIKeys.QUERY: text]
        )
        let keywordCancellable = apiService.request(keywordRequest, dataType: KeywordsResponse.self)
            .sink { status in
                print(status)
            } receiveValue: { value in
                print("Search keyword with keyword \(text): lenght of result is \(value.results.count)")
                var results = value.results
                results.limitCount()
                self.searchedKeywords = results
            }
        
        let movieRequest = CinefyApi.searchMovie(
            query: [APIKeys.QUERY: text]
        )
        let movieCancellable = apiService.request(movieRequest, dataType: PagedResponse<Movie>.self)
            .sink { status in
                print(status)
            } receiveValue: { value in
                print("Search movie with keyword \(text): lenght of result is \(value.results.count)")
                self.searchedMovies = value.results.onlyAvailableImage()
            }
        
        let peopleRequest = CinefyApi.searchPeople(
            query: [APIKeys.QUERY: text]
        )
        let peopleCancellable = apiService.request(peopleRequest, dataType: PeopleResponse.self)
            .sink { status in print(status) } receiveValue: { value in
                print("Search people with keyword \(text): lenght of result is \(value.results.count)")
                self.people = value.results
            }
        
        cancellables.insert(keywordCancellable)
        cancellables.insert(movieCancellable)
        cancellables.insert(peopleCancellable)
    }
}
