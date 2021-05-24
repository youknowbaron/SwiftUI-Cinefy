//
//  File.swift
//  Cinefy
//
//  Created by vobach on 13/05/2021.
//

import Foundation

protocol APIBuilder {
    var urlRequest: URLRequest { get }
    
    var path: String { get }
    
    var baseUrl: URL { get }
}

enum CinefyApi {
    
    // MARK: - API: Authentication
    case requestToken
    
    case createSession(body: [String: Any])
    
    case createSessionWithLogin(body: [String: Any])
    
    case getDetailAccount(query: [String: String])
    
    case markAsFavorite(accountId: Int, query: [String: String], body:[String:Any])
    
    case addToWatchlist(accountId: Int, query: [String: String], body:[String:Any])
    
    case getFavoriteMovies(accountId: Int, query: [String: String])
    
    case getWatchlistMovies(accountId: Int, query: [String: String])
    
    // MARK: - API: Movies
    case getNowPlayingMovies(query: [String: String] = [:])
    
    case getPopularMovies
    
    case getUpcomingMovies(query: [String: String] = [:])
    
    case getMovieDetail(Int)
    
    case getCredits(movieId: Int)
    
    case getReviews(movieId: Int)
    
    case getRecommendations(movieId: Int)
    
    case getSimilar(movieId: Int)
    
    case getMovieState(id: Int, query: [String: String])
    
    // MARK: - API: Search
    
    case searchMulti(query: [String: String])
    
    case searchKeyword(query: [String: String])
    
    case searchPeople(query: [String: String])
    
    case searchMovie(query: [String: String])
    
    // MARK: - Path: Person
    case getDetailPerson(id: Int)
}

class APIKeys {
    static let SESSION_ID = "session_id"
    static let QUERY = "query"
    static let PAGE = "page"
}

extension CinefyApi : APIBuilder {
    var urlRequest: URLRequest {
        var urlRequest = URLRequest(url: baseUrl.appendingPathComponent(path))
        switch self {
        case .createSession(let body), .createSessionWithLogin(let body),
             .markAsFavorite(_, _, let body), .addToWatchlist(_, _, let body):
            let jsonBody = try! JSONSerialization.data(withJSONObject: body)
            urlRequest.httpMethod = "POST"
            urlRequest.httpBody = jsonBody
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
        default: break
        }
        return urlRequest
    }
    
    var path: String {
        switch self {
        // MARK: - Path: Authentication
        case .requestToken:
            return "authentication/token/new"
        case .createSession(_):
            return "authentication/session/new"
        case .createSessionWithLogin(_):
            return "authentication/token/validate_with_login"
        case .getDetailAccount(_):
            return "account"
        case .markAsFavorite(let accountId, _, _):
            return "/account/\(accountId)/favorite"
        case .addToWatchlist(let accountId, _, _):
            return "/account/\(accountId)/watchlist"
        case .getFavoriteMovies(let accountId, _):
            return "/account/\(accountId)/favorite/movies"
        case .getWatchlistMovies(let accountId, _):
            return "/account/\(accountId)/watchlist/movies"
        // MARK: - Path: Movies
        case .getNowPlayingMovies(_):
            return "movie/now_playing"
        case .getPopularMovies:
            return "movie/popular"
        case .getUpcomingMovies(_):
            return "movie/upcoming"
        case .getMovieDetail(let id):
            return "movie/\(id)"
        case .getCredits(let id):
            return "movie/\(id)/credits"
        case .getReviews(let id):
            return "movie/\(id)/reviews"
        case .getRecommendations(let id):
            return "movie/\(id)/recommendations"
        case .getSimilar(let id):
            return "movie/\(id)/similar"
        case .getMovieState(let id, _):
            return "movie/\(id)/account_states"
        // MARK: - Path: Search
        case .searchMulti(_):
            return "search/multi"
        case .searchKeyword(_):
            return "search/keyword"
        case .searchPeople(_):
            return "search/person"
        case .searchMovie(_):
            return "search/movie"
            // MARK: - Path: Person
        case .getDetailPerson(let id):
            return "person/\(id)"
        }
    }
    
    var baseUrl: URL {
        var url = URL(string: "https://api.themoviedb.org/3")!.addQuery(queries: ["api_key": "4de371dea47b9a5dcd86c1cf83c48d4e"])
        switch self {
        case .getDetailAccount(let query), .addToWatchlist(_, let query, _),
             .markAsFavorite(_, let query, _), .getMovieState(_, let query),
             .getFavoriteMovies(_, let query), .getWatchlistMovies(_, let query),
             .searchMulti(let query), .searchKeyword(let query),
             .searchPeople(let query), .searchMovie(let query),
             .getNowPlayingMovies(let query), .getUpcomingMovies(let query):
            url = url.addQuery(queries: query)
            break
        default:
            break
        }
        return url
    }
}

extension URL {
    func addQuery(queries: [String: String]) -> URL {
        guard var urlComponents = URLComponents(string: absoluteString) else {
            return absoluteURL
        }
        // Create array of existing query items
        var queryItems: [URLQueryItem] = urlComponents.queryItems ??  []
        // Create query item
        queries.forEach { key, value in
            let queryItem = URLQueryItem(name: key, value: value)
            // Append the new query item in the existing query items array
            queryItems.append(queryItem)
        }
        // Append updated query items array in the url component object
        urlComponents.queryItems = queryItems
        // Returns the url from new url components
        return urlComponents.url!
    }
}
