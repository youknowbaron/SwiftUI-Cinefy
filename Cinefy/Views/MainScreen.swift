//
//  MainScreen.swift
//  Cinefy
//
//  Created by vobach on 20/05/2021.
//

import SwiftUI

struct MainScreen: View {
    
    enum Tab {
        case movies, watchlist
    }
    
    @State private var selectingTab = Tab.movies
    
    @Environment(\.presentationMode) var presentationMode
    
    func tabItem(text: String, image: String) -> some View {
        VStack {
            Image(systemName: image)
                .imageScale(.large)
            Text(text)
        }
    }
    
    var body: some View {
        TabView(selection: $selectingTab) {
            MoviesScreen()
                .tabItem { tabItem(text: "Movies", image: "film") }
                .tag(Tab.movies)
            Text("Watchlist")
                .tabItem { tabItem(text: "Watchlist", image: "checkmark.rectangle") }
                .tag(Tab.watchlist)
        }
    }
}

struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen()
    }
}
