//
//  PopularHeader.swift
//  Cinefy
//
//  Created by vobach on 18/05/2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct PopularHeaderView: View {
    
    var movie: Movie
    var no: Int
    
    var body: some View {
        
        GeometryReader { geometry in
            
            ZStack(alignment: .bottom) {
                
                WebImage(url: URL(string: movie.posterPath!.addImageUrl(quality: 500))!)
                    .resizable()
                    .frame(width: geometry.size.width, height: geometry.size.width * 1.5)
                    .scaledToFit()
                    .aspectRatio(2/3, contentMode: .fit)
                    .overlay(LinearGradient(
                        gradient: Gradient(colors: [.bgColor.opacity(0.75), .bgColor.opacity(0), .bgColor]),
                        startPoint: UnitPoint(x: 0.5, y: 0),
                        endPoint: UnitPoint(x: 0.5, y: 1)
                    ))
                
                
                VStack(spacing: 15) {
                    
                    Spacer()
                    
                    Text(movie.title)
                        .font(.system(size: 28, weight: .bold))
                        .lineSpacing(0.1)
                    
                    HStack(spacing: 10) {
                        Top10Badge(top: 20)
                        
                        Text("#\(no) in Popular Today")
                            .font(.system(size: 16, weight: .bold))
                    }
                    
                    HStack {
                        Spacer()
                        
                        VStack(spacing: 5) {
                            Image(systemName: "plus")
                            Text("Watchlist")
                                .font(.system(size: 12, weight: .light))
                                .foregroundColor(.subTextColor)
                        }
                        Spacer()
                        
                        HStack(spacing: 10) {
                            Image(systemName: "play.fill")
                            Text("Play")
                                .fontWeight(.medium)
                        }
                        .foregroundColor(.bgColor)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(Color.white)
                        .cornerRadius(5)
                        
                        Spacer()
                        
                        NavigationLink(
                            destination: DetailMovieScreen(movie: movie)
                                .navigationBarTitle("")
                                .navigationBarHidden(true)
                        ) {
                            VStack(spacing: 5) {
                                Image(systemName: "info.circle")
                                Text("Info")
                                    .font(.system(size: 12, weight: .light))
                                    .foregroundColor(.subTextColor)
                            }
                            .padding()
                        }
                        
                        Spacer()
                    }
                }
                .padding(.horizontal, 40)
            }}
    }
}

