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
    
    private(set) var state: ResultState<Bool>? {
        didSet {
            switch self.state {
            case .loading:
                shouldShowAlert = false
                isLoginSuccess = false
                break
            case .failed(_):
                isLoginSuccess = false
                shouldShowAlert = true
                break
            case .success:
                isLoginSuccess = true
                shouldShowAlert = false
                break
            case .none:
                break
            }
        }
    }
    @Published var isLoginSuccess: Bool = false
    @Published var shouldShowAlert = false
    
    func getRquestToken() {
        let cancellable = apiService.request(.requestToken, dataType: TokenResponse.self)
            .sink { status in
                switch status {
                case .finished:
                    break
                case .failure(let error):
                    print("Error: \(error.errorDescription ?? "")")
                    self.state = .failed(error: error)
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
                    break
                case .failure(let error):
                    print("Error: \(error.errorDescription ?? "")")
                    self.state = .failed(error: error)
                    break
                }
            } receiveValue: { value in
                UserDefaults.standard.set(value.sessionID, forKey: "session_id")
                print("SessionID: \(value.sessionID)")
            }
        cancellables.insert(cancellable)
    }
}
