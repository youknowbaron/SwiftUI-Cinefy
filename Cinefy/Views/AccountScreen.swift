//
//  AccountScreen.swift
//  Cinefy
//
//  Created by vobach on 21/05/2021.
//

import SwiftUI

struct AccountScreen: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var account = UserState.account!
    
    var onLogout: () -> Void
    
    var body: some View {
        print(account)
        return List {
            AvatarView(url: account.avatar.tmdb.avatarPath, size: 120)
            
            Button("Logout") {
                UserState.logout()
                presentationMode.wrappedValue.dismiss()
                onLogout()
            }
            .foregroundColor(.highlightColor)
        }
        .navigationBarTitle(account.nameTitle)
    }
}

struct AccountScreen_Previews: PreviewProvider {
    static var previews: some View {
        AccountScreen {  }
    }
}
