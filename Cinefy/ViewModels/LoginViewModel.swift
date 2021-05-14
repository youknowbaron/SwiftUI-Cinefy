//
//  LoginViewModel.swift
//  Cinefy
//
//  Created by vobach on 14/05/2021.
//

import Foundation
import Combine

class LoginViewModel: ObservableObject {
    
    private var apiService: APIService
    
    init(apiService: APIService) {
        self.apiService = apiService
    }
    
}
