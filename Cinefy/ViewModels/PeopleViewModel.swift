//
//  PeopleViewModel.swift
//  Cinefy
//
//  Created by vobach on 21/05/2021.
//

import Foundation
import Combine

class PeopleViewModel: ObservableObject {
    
    private var apiService: APIService
    private var cancellables = Set<AnyCancellable>()
    
    @Published private(set) var detailCast: Cast?
    
    init(apiService: APIService) {
        print("[Init] PeopleViewModel")
        self.apiService = apiService
    }
    
    deinit {
        print("[Deinit] PeopleViewModel")
        cancellables.forEach { $0.cancel() }
    }
    
    func getDetailCast(id: Int) {
        let cancellable = apiService.request(.getDetailPerson(id: id), dataType: Cast.self)
            .sink { status in
                print(status)
            } receiveValue: { value in
                self.detailCast = value
                print("Detail Cast: \(value)")
            }
        
        cancellables.insert(cancellable)
    }
}
