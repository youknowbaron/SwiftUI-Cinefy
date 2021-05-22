//
//  AskToLoginView.swift
//  Cinefy
//
//  Created by vobach on 21/05/2021.
//

import SwiftUI

struct AskToLoginView: View {
    
    @State private var showLoginSheet = false
    var onLogin: (Account) -> Void
    var message: String
    
    init(_ message: String, onLogin: @escaping (Account) -> Void) {
        self.message = message
        self.onLogin = onLogin
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            
            Text(message)
                .foregroundColor(.subTextColor)
            
            HStack {
                Spacer()
                
                Button("Login") {
                    showLoginSheet = true
                }
                .foregroundColor(.highlightColor)
                .sheet(isPresented: $showLoginSheet) {
                    LoginSheet { account in
                        onLogin(account)
                    }
                }
                
                Spacer()
            }
        }
        .padding(10)
    }
}
