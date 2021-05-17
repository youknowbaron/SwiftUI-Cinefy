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
    
    case requestToken
    
    case createSession(body: [String: String])
    
    case createSessionWithLogin(body: [String: String])
    
    case getDetailAccount(sessionId: String)
}

extension CinefyApi : APIBuilder {
    var urlRequest: URLRequest {
        var urlRequest = URLRequest(url: baseUrl.appendingPathComponent(path))
        switch self {
        case .createSession(let body), .createSessionWithLogin(let body):
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
        case .getNowPlayingMovie:
            return "movie/now_playing"
        case .getMovieDetail(let id):
            return "movie/\(id)"
        case .requestToken:
            return "authentication/token/new"
        case .createSession(_):
            return "authentication/session/new"
        case .createSessionWithLogin(_):
            return "authentication/token/validate_with_login"
        case .getDetailAccount(_):
            return "account"
        }
    }
    
    var baseUrl: URL {
        var url = URL(string: "https://api.themoviedb.org/3")!.addQuery(queries: ["api_key": "4de371dea47b9a5dcd86c1cf83c48d4e"])
        switch self {
        case .getDetailAccount(let sessionId):
            url = url.addQuery(queries: ["session_id" : sessionId])
            break
        default:
            break
        }
        return URL(string: "https://api.themoviedb.org/3")!.addQuery(queries: ["api_key": "4de371dea47b9a5dcd86c1cf83c48d4e"])
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
