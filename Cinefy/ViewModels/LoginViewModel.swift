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
    
    private var cancellables = Set<AnyCancellable>()
    
    private var requestToken: String?
    
    @Published var state: ResultState<Bool>?
    @Published var isSuccess: Bool?
    
    func getRquestToken() {
        let cancellable = apiService.request(.requestToken, dataType: TokenResponse.self)
            .sink { status in
                switch status {
                case .finished:
                    break
                case .failure(let error):
                    print("Error: \(error.errorDescription ?? "")")
                    self.isSuccess = false
                    break
                }
            } receiveValue: { value in
                self.requestToken = value.requestToken
                print("RequesToken: \(self.requestToken ?? "")")
            }
        
        cancellables.insert(cancellable)
    }
    
    func login(username: String, password: String) {
        state = .loading
        createSessionWithLogin(username: username, password: password)
    }
    
    private func createSessionWithLogin(username: String, password: String) {
        let cancellable = apiService.request(
            .createSessionWithLogin(body: ["username": username, "password": password, "request_token": requestToken ?? ""]),
            dataType: TokenResponse.self
        ).sink { status in
            switch status {
            case .finished:
                break
            case .failure(let error):
                print("Error: \(error.errorDescription ?? "")")
                self.state = .failed(error: error)
                self.isSuccess = false
                break
            }
        } receiveValue: { value in
            self.createSession()
        }
        
        cancellables.insert(cancellable)
    }
    
    private func createSession() {
        let cancellable = apiService.request(.createSession(body: ["request_token" : requestToken ?? ""]), dataType: SessionIDResponse.self)
            .sink { status in
                switch status {
                case .finished:
                    self.state = .success(data: true)
                    self.isSuccess = true
                    break
                case .failure(let error):
                    print("Error: \(error.errorDescription ?? "")")
                    self.state = .failed(error: error)
                    self.isSuccess = false
                    break
                }
            } receiveValue: { value in
                UserDefaults.standard.set(value.sessionID, forKey: "session_id")
                print("SessionID: \(value.sessionID)")
            }
        cancellables.insert(cancellable)
    }
}
