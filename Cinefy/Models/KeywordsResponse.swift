//
//  KeywordsResponse.swift
//  Cinefy
//
//  Created by vobach on 19/05/2021.
//

import Foundation

// MARK: - KeywordsResponse
struct KeywordsResponse: Codable {
    let page: Int
    let results: [Keyword]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
