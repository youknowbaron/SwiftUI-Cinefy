//
//  TokenResponse.swift
//  Cinefy
//
//  Created by vobach on 17/05/2021.
//

import Foundation

// MARK: - TokenResponse
struct TokenResponse: Codable {
    let success: Bool
    let expiresAt, requestToken: String

    enum CodingKeys: String, CodingKey {
        case success
        case expiresAt = "expires_at"
        case requestToken = "request_token"
    }
}
