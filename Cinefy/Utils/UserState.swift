//
//  UserState.swift
//  Cinefy
//
//  Created by vobach on 21/05/2021.
//

import Foundation

class UserState {
    static var isLogin = false
    
    static var sessionID: String? {
        didSet {
            isLogin = sessionID != nil
        }
    }
    
    static var account: Account?
    
    static func initialize() {
        sessionID = UserDefaults.standard.object(forKey: "session_id") as? String
        if sessionID != nil {
            account = Account(json: UserDefaults.standard.data(forKey: "account"))
        }
    }
    
    static func logout() {
        sessionID = nil
        account = nil
        UserDefaults.standard.removeObject(forKey: "session_id")
        UserDefaults.standard.removeObject(forKey: "account")
    }
    
}
