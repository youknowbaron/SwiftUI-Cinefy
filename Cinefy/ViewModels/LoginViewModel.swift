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
    
    deinit {
        print("deinit LoginViewModel")
        cancellables.forEach { $0.cancel() }
    }
    
    let loginSubject = PassthroughSubject<Bool, Never>()
    
    private var cancellables = Set<AnyCancellable>()
    
    private(set) var state: ResultState<Bool>? {
        didSet {
            switch self.state {
            case .loading:
                shouldShowAlert = false
                break
            case .failed(_):
                shouldShowAlert = true
                break
            case .success:
                shouldShowAlert = false
                loginSubject.send(true)
                break
            case .none:
                break
            }
        }
    }
    
    @Published var shouldShowAlert = false
    
    func login(username: String, password: String) {
        state = .loading
        getRquestToken(username: username, password: password)
    }
    
    private func getRquestToken(username: String, password: String) {
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
                print("RequesToken: \(value.requestToken)")
                self.createSessionWithLogin(username: username, password: password, requestToken: value.requestToken)
            }
        
        cancellables.insert(cancellable)
    }
    
    private func createSessionWithLogin(username: String, password: String, requestToken: String) {
        let cancellable = apiService.request(
            .createSessionWithLogin(body: ["username": username, "password": password, "request_token": requestToken]),
            dataType: TokenResponse.self
        ).sink { status in
            switch status {
            case .finished:
                break
            case .failure(let error):
                print("[Error] createSessionWithLogin: \(error.errorDescription ?? "")")
                self.state = .failed(error: error)
                break
            }
        } receiveValue: { value in
            self.createSession(requestToken: requestToken)
        }
        
        cancellables.insert(cancellable)
    }
    
    private func createSession(requestToken: String) {
        let cancellable = apiService.request(.createSession(body: ["request_token": requestToken]), dataType: SessionIDResponse.self)
            .sink { status in
                switch status {
                case .finished:
                    self.state = .success(data: true)
                    break
                case .failure(let error):
                    print("[Error] createSession: \(error.errorDescription ?? "")")
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
