//
//  SessionIDResponse.swift
//  Cinefy
//
//  Created by vobach on 17/05/2021.
//

import Foundation

// MARK: - SessionIDResponse
struct SessionIDResponse: Codable {
    let success: Bool
    let sessionID: String

    enum CodingKeys: String, CodingKey {
        case success
        case sessionID = "session_id"
    }
}
