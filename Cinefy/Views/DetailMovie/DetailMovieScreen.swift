//
//  MovieDetailScreen.swift
//  Cinefy
//
//  Created by vobach on 13/05/2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct DetailMovieScreen: View {
    
    @ObservedObject var viewModel : DetailMovieViewModel
    
    init(movie: Movie) {
        self.viewModel = DetailMovieViewModel(apiService: APIServiceImpl(), movie: movie)
    }
    
    var body: some View {
        
        let movie = viewModel.detailMovie
        
        NavigationView {
            
            GeometryReader { geometry in
                let width = geometry.size.width
                
                ZStack(alignment: .topLeading) {
                    Color.bgColor
                    
                    WebImage(url: URL(string: movie.posterPath!.addImageUrl(quality: 500))!)
                        .resizable()
                        .frame(width: width, height: width * 1.5)
                        .scaledToFit()
                        .aspectRatio(2/3, contentMode: .fit)
                    
                    ScrollView {
                        
                        VStack(alignment: .leading, spacing: 0) {
                            
                            VStack(alignment: .leading, spacing: 20) {
                               
                                Image(systemName: "play.fill")
                                    .buttify(backgroundColor: .white.opacity(0.17))
                                    .onTapGesture {
                                        print("on play tap")
                                    }
                                
                                Text(movie.title)
                                    .font(.system(size: 38, weight: .bold))
                                
                                Text(movie.genres?.toString() ?? "")
                                    .foregroundColor(.subTextColor)
                                
                                MyButton("Watch movie") {}
                                
                                HStack {
                                    Image(systemName: "arrow.down")
                                        .buttify()
                                    Spacer()
                                    Image(systemName: "heart")
                                        .buttify()
                                    Spacer()
                                    Image(systemName: "arrowshape.turn.up.right")
                                        .buttify()
                                }
                                .padding(.top, 10)
                            }
                            .padding([.top, .horizontal], 40)
                            .background(LinearGradient(
                                gradient: Gradient(colors: [.bgColor.opacity(0), .bgColor]),
                                startPoint: UnitPoint(x: 0.5, y: 0),
                                endPoint: UnitPoint(x: 0.5, y: 1)
                            ))
                            
                            VStack(alignment: .leading, spacing: 20) {
                                
                                VStack(spacing: 15) {
                                    RatingView(movie.voteAverage, insertSpacer: true)
                                    InformationLine(key: "Vote count", value: String(movie.voteCount))
                                    InformationLine(key: "Popularity", value: String(movie.popularity))
                                }
                                .padding(20)
                                .overlyfy()
                                
                                VStack(alignment: .leading, spacing: 15) {
                                    IconLine(iconName: "calendar", value: movie.releaseDate)
                                    IconLine(iconName: "clock", value: "\(movie.runtime ?? 0) minutes")
                                    IconLine(iconName: "map", value: movie.productionCountries?.toString() ?? "")
                                    IconLine(iconName: "speaker.2", value: movie.spokenLanguages?.toString() ?? "")
                                }
                                .padding(20)
                                .frame(maxWidth: .infinity)
                                .overlyfy()
                                
                                VStack(alignment: .leading, spacing: 10) {
                                    Text("Description")
                                        .font(.system(size: 16, weight: .medium))
                                    Text(movie.overview)
                                        .foregroundColor(.subTextColor)
                                        .lineLimit(9999)
                 
                                }
                                .padding(20)
                                .overlyfy()
                                
                                Text("Cast")
                                    .font(.system(size: 16, weight: .medium))
                                
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 20) {
                                        ForEach(viewModel.cast) { cast in
                                            CastItem(cast: cast)
                                        }
                                    }
                                }
                                
                            }
                            .padding(.horizontal, 20)
                            .padding(.vertical, 40)
                            .background(Color.bgColor)
                        }
                        .padding(.top, width / 2)
                    }
                    
                }
                .foregroundColor(.textColor)
                .navigationBarTitle("")
                .navigationBarHidden(true)
                .ignoresSafeArea()
            }
        }
        .onAppear {
            viewModel.getDetailMovie(id: movie.id)
            viewModel.getCast(id: movie.id)
        }
    }
}

struct IconLine: View {
    
    var iconName: String
    var value: String
    
    var body: some View {
        HStack {
            Image(systemName: iconName).foregroundColor(.highlightColor)
            Text(value).padding(.leading, 10)
                .foregroundColor(.subTextColor)
            Spacer()
        }
    }
}

struct InformationLine: View {
    
    var key: String
    var value: String
    
    var body: some View {
        HStack {
            Text(key).foregroundColor(.textColor)
            Spacer()
            Text(value).foregroundColor(.white)
                .font(.system(size: 14, weight: .bold))
        }
    }
}
//struct MovieDetailScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        MovieDetailScreen()
//    }
//}
