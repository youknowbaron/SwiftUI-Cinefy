//
//  Review.swift
//  Cinefy
//
//  Created by vobach on 18/05/2021.
//

import Foundation

// MARK: - Review
struct Review: Codable, Identifiable {
    let author: String
    let content, createdAt, id, updatedAt: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case author
        case content
        case createdAt = "created_at"
        case id
        case updatedAt = "updated_at"
        case url
    }
}
