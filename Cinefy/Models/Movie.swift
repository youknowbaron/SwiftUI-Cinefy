//
//  Movie.swift
//  Cinefy
//
//  Created by vobach on 13/05/2021.
//

import Foundation

// MARK: - Movie
struct Movie: Codable, Identifiable {
    let adult: Bool
    let backdropPath: String?
    let genreIDS: [Int]?
    let budget: Int?
    let genres: [Genre]?
    let homepage: String?
    let id: Int
    let imdbID: String?
    let originalLanguage, originalTitle, overview: String
    let popularity: Double
    let posterPath: String?
    let releaseDate, title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
    let productionCompanies: [ProductionCompany]?
    let productionCountries: [ProductionCountry]?
    let revenue, runtime: Int?
    let spokenLanguages: [SpokenLanguage]?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case budget, genres, homepage, id
        case imdbID = "imdb_id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case revenue, runtime
        case spokenLanguages = "spoken_languages"
    }

    func copy() -> Movie {
        return Movie(adult: adult, backdropPath: backdropPath, genreIDS: genreIDS, budget: budget, genres: genres, homepage: homepage, id: id, imdbID: imdbID, originalLanguage: originalLanguage, originalTitle: originalTitle, overview: overview, popularity: popularity, posterPath: posterPath, releaseDate: releaseDate, title: title, video: video, voteAverage: voteAverage, voteCount: voteCount, productionCompanies: productionCompanies, productionCountries: productionCountries, revenue: revenue, runtime: runtime, spokenLanguages: spokenLanguages)
    }
}
