//
//  UserState.swift
//  Cinefy
//
//  Created by vobach on 22/05/2021.
//

import Foundation

class UserState {
    static var isLogin: Bool = false
    static var account: Account?
    
    static var sessionID: String? {
        willSet {
            isLogin = newValue != nil
        }
    }
    
    static func initialize() {
        sessionID = UserDefaults.standard.object(forKey: "session_id") as? String
        if sessionID != nil {
            account = Account(json: UserDefaults.standard.data(forKey: "account"))
            print("[UserState initialize] \(String(describing: account))")
        }
    }
    
    static func logout() {
        sessionID = nil
        account = nil
        UserDefaults.standard.removeObject(forKey: "session_id")
        UserDefaults.standard.removeObject(forKey: "account")
    }
}
