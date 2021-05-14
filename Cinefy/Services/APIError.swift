//
//  APIError.swift
//  Cinefy
//
//  Created by vobach on 13/05/2021.
//

import Foundation

enum APIError {
    case decodingError
    case errorCode(Int)
    case unknown
}

extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .decodingError:
            return "Failed to decode the object from the service"
        case .errorCode(let code):
            return "\(code) - Something went wrong"
        case .unknown:
            return "Unknown error"
        }
    }
}
