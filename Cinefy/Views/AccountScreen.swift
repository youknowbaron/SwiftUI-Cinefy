//
//  AccountScreen.swift
//  Cinefy
//
//  Created by vobach on 21/05/2021.
//

import SwiftUI

struct AccountScreen: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var userViewModel: UserViewModel
    
    var onLogout: () -> Void
    
    var body: some View {
        let account = userViewModel.account
        Group {
            if let account = account {
                List {
                    AvatarView(url: account.avatar.tmdb.avatarPath, size: 120)
                    
                    Button("Logout") {
                        presentationMode.wrappedValue.dismiss()
                        userViewModel.logout()
                        onLogout()
                    }
                    .foregroundColor(.highlightColor)
                }
            } else {
                EmptyView()
            }
        }
        .navigationBarTitle(account?.nameTitle ?? "")
    }
}

struct AccountScreen_Previews: PreviewProvider {
    static var previews: some View {
        AccountScreen {  }
    }
}
