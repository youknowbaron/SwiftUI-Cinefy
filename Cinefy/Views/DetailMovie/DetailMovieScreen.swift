//
//  MovieDetailScreen.swift
//  Cinefy
//
//  Created by vobach on 13/05/2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct DetailMovieScreen: View {
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel = DetailMovieViewModel(apiService: APIServiceImpl())
    
    var movie: Movie
    
    var body: some View {
        let movie = viewModel.detailMovie ?? movie
        
        GeometryReader { geometry in
            let width = geometry.size.width
            
            ZStack(alignment: .topLeading) {
                
                WebImage(url: URL(string: movie.posterPath!.addImageUrl(quality: 500))!)
                    .resizable()
                    .frame(width: width, height: width * 1.5)
                    .scaledToFit()
                    .aspectRatio(2/3, contentMode: .fit)
                    .ignoresSafeArea()
                
                ScrollView {
                    contentView(movie: movie)
                        .padding(.top, width / 2)
                }
                .ignoresSafeArea(edges: .top)
            
            }
            .foregroundColor(.textColor)
        }
        .navigationBarTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: closeButton)
        .onAppear {
            viewModel.getDetailMovie(id: movie.id)
            viewModel.getCast(id: movie.id)
            viewModel.getMovieState(id: movie.id)
        }
    }
    
    var closeButton: some View {
        Image(systemName: "multiply")
            .padding()
            .onTapGesture {
                presentationMode.wrappedValue.dismiss()
            }
    }
    
    func contentView(movie: Movie) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            
            VStack(alignment: .leading, spacing: 20) {
                
                Image(systemName: "play.fill")
                    .buttify(backgroundColor: .white.opacity(0.17))
                    .onTapGesture {
                        presentationMode.wrappedValue.dismiss()
                    }
                
                Text(movie.title)
                    .font(.system(size: 38, weight: .bold))
                
                Text(movie.genres?.toString() ?? "")
                    .foregroundColor(.subTextColor)
                
                MyButton("Watch movie") {}
                
                HStack {
                    Image(systemName:
                            viewModel.isAdded2Watchlist ? "checkmark" : "plus")
                        .foregroundColor(viewModel.isAdded2Watchlist ? .highlightColor : nil)
                        .buttify()
                        .onTapGesture {
                            viewModel.addToWatchlist(mediaId: movie.id)
                        }
                    
                    Spacer()
                    Image(systemName: viewModel.isFavorited ? "heart.fill" : "heart")
                        .foregroundColor(viewModel.isFavorited ? .highlightColor : nil)
                        .buttify()
                        .onTapGesture {
                            viewModel.markAsFavorite(mediaId: movie.id)
                        }
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
                
                HStack {
                
                    Text("Cast")
                        .font(.system(size: 16, weight: .medium))
                    
                    Spacer()
                    
                    Button("See All") {
                        
                    }
                    .foregroundColor(.highlightColor)
                }
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        ForEach(viewModel.cast) { cast in
                            NavigationLink(destination: DetailCastScreen(cast: cast)) {
                                CastItem(cast: cast)
                            }
                        }
                    }
                }
                
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 40)
            .background(Color.bgColor)
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
