//
//  APIError.swift
//  Cinefy
//
//  Created by vobach on 13/05/2021.
//

import Foundation

enum APIError {
    case decodingError
    case errorCode(Int, String = "Unknown error")
    case unknown
}

extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .decodingError:
            return "Failed to decode the object from the service"
        case .errorCode(let code, let message):
            return "\(code) - \(message)"
        case .unknown:
            return "Unknown error"
        }
    }
}
