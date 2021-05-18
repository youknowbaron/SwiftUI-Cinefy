//
//  CreditsResponse.swift
//  Cinefy
//
//  Created by vobach on 18/05/2021.
//

import Foundation

// MARK: - CreditsResponse
struct CreditsResponse: Codable {
    let id: Int
    let cast: [Cast]
}
