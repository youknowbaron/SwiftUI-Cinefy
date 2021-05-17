//
//  ErrorResponse.swift
//  Cinefy
//
//  Created by vobach on 17/05/2021.
//

import Foundation

// MARK: - ErrorResponse
struct ErrorResponse: Codable {
    let success: Bool
    let statusCode: Int
    let statusMessage: String

    enum CodingKeys: String, CodingKey {
        case success
        case statusCode = "status_code"
        case statusMessage = "status_message"
    }
}
