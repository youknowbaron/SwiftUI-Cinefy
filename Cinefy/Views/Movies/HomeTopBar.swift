//
//  HomeTopBar.swift
//  Cinefy
//
//  Created by vobach on 18/05/2021.
//

import SwiftUI

struct HomeTopBar: View {
    var logOut: (() -> Void)
    
    var body: some View {
        HStack {
            
            Image("logo_cinefy")
                .resizable()
                .scaledToFit()
                .frame(width: 100)
                .padding(.leading, 20)
            
            Spacer()
            
            NavigationLink(destination: SearchScreen()) {
                Image(systemName: "magnifyingglass")
                    .padding()
            }
            
            
            Image(systemName: "arrow.uturn.right")
                .padding()
                .onTapGesture {
                    logOut()
                }
        }
    }
}

