//
//  ReviewsResponse.swift
//  Cinefy
//
//  Created by vobach on 18/05/2021.
//

import Foundation

// MARK: - ReviewsResponse
struct ReviewsResponse: Codable {
    let id, page: Int
    let results: [Review]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case id, page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
