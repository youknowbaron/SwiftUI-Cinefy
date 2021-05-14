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
    case getNowPlayingMovie
    
    case getMovieDetail(Int)
}

extension CinefyApi : APIBuilder {
    var urlRequest: URLRequest {
        return URLRequest(url: baseUrl.appendingPathComponent(path))
    }
    
    var path: String {
        switch self {
        case .getNowPlayingMovie:
            return "movie/now_playing"
        case .getMovieDetail(let id):
            return "movie/\(id)"
        }
    }
    
    var baseUrl: URL {
        return URL(string: "https://api.themoviedb.org/3")!.addQuery("api_key", value: "4de371dea47b9a5dcd86c1cf83c48d4e")
    }
}

extension URL {

    func addQuery(_ key: String, value: String?) -> URL {
        guard var urlComponents = URLComponents(string: absoluteString) else {
            return absoluteURL
        }

        // Create array of existing query items
        var queryItems: [URLQueryItem] = urlComponents.queryItems ??  []

        // Create query item
        let queryItem = URLQueryItem(name: key, value: value)

        // Append the new query item in the existing query items array
        queryItems.append(queryItem)

        // Append updated query items array in the url component object
        urlComponents.queryItems = queryItems

        // Returns the url from new url components
        return urlComponents.url!
    }
}
