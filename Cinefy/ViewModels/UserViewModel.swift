//
//  LoginViewModel.swift
//  Cinefy
//
//  Created by vobach on 14/05/2021.
//

import Foundation
import Combine

class UserViewModel: ObservableObject {
    
    private var apiService: APIService
    
    @Published private(set) var isLogin = false
    private(set) var account: Account?
    private(set) var sessionId: String?
    
    init(apiService: APIService) {
        self.apiService = apiService
        UserState.initialize()
        updateUserState()
    }
    
    deinit {
        print("deinit LoginViewModel")
        cancellables.forEach { $0.cancel() }
    }

    
    let loginSubject = PassthroughSubject<Account, Never>()
    
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
                break
            case .none:
                break
            }
        }
    }
    
    @Published var shouldShowAlert = false
    
    // MARK: APIs
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
                    break
                case .failure(let error):
                    print("[Error] createSession: \(error.errorDescription ?? "")")
                    self.state = .failed(error: error)
                    break
                }
            } receiveValue: { value in
                UserDefaults.standard.set(value.sessionID, forKey: "session_id")
                UserState.sessionID = value.sessionID
                print("SessionID: \(value.sessionID)")
                self.getAccountDetail(sessionId: value.sessionID)
            }
        cancellables.insert(cancellable)
    }
    
    private func getAccountDetail(sessionId: String) {
        let cancellable = apiService.request(.getDetailAccount(sessionId: sessionId), dataType: Account.self)
            .sink { status in
                switch status {
                case .finished:
                    self.state = .success(data: true)
                    break
                case .failure(let error):
                    print("[Error] getAccount: \(error.errorDescription ?? "")")
                    self.state = .failed(error: error)
                    break
                }
            } receiveValue: { account in
                UserDefaults.standard.set(account.json, forKey: "account")
                UserState.account = account
                self.updateUserState()
                self.loginSubject.send(account)
            }
        
        cancellables.insert(cancellable)
    }
    
    func logout() {
        UserState.logout()
        updateUserState()
    }
    
    private func updateUserState() {
        sessionId = UserState.sessionID
        account = UserState.account
        isLogin = UserState.isLogin
    }
}
