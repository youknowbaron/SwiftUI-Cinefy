//
//  MovieDetailScreen.swift
//  Cinefy
//
//  Created by vobach on 13/05/2021.
//

import SwiftUI
import URLImage

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
                    
                    let url = URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath)")!
                    
                    URLImage(url) { image in
                        image
                            .resizable()
                            .aspectRatio(2/3, contentMode: .fit)
                    }
                    .frame(height: width * CGFloat(3/2))
                    
//                    Image("test_poster")
//                        .resizable()
//                        .aspectRatio(2/3, contentMode: .fit)
                    
                    ScrollView {
                        
                        VStack(alignment: .leading, spacing: 0) {
                            
                            VStack(alignment: .leading, spacing: 20) {
                                Group {
                                    Image(systemName: "play.fill")
                                        .foregroundColor(.white)
                                        .padding(25)
                                }
                                .background(Color.white.opacity(0.17))
                                .cornerRadius(25)
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
                            .padding(40)
                            .background(LinearGradient(
                                gradient: Gradient(colors: [.bgColor.opacity(0), .bgColor]),
                                startPoint: UnitPoint(x: 0.5, y: 0),
                                endPoint: UnitPoint(x: 0.5, y: 1)
                            ))
                            
                            VStack(alignment: .leading, spacing: 20) {
                                
                                VStack(spacing: 15) {
                                    RatingView(movie.voteAverage, insertSpacer: true)
                                    InformationLine(key: "Vote cound", value: String(movie.voteCount))
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
                                .frame(maxWidth: .infinity)
                                .padding(20)
                                .overlyfy()
                                
                                VStack(alignment: .leading, spacing: 10) {
                                    Text("Description")
                                        .font(.system(size: 16, weight: .medium))
                                    Text(movie.overview)
                                        .foregroundColor(.subTextColor)
                 
                                }
                                .padding(20)
                                .overlyfy()
                            }
                            .padding(.horizontal, 20)
                            .padding(.bottom, 40)
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
        }
    }
}

struct IconLine: View {
    
    var iconName: String
    var value: String
    
    var body: some View {
        HStack(alignment: .top) {
            Image(systemName: iconName).foregroundColor(.highlightColor)
            Text(value).padding(.leading, 10)
                .foregroundColor(.subTextColor)
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
