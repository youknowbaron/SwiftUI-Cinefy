//
//  PagedResponse.swift
//  Cinefy
//
//  Created by vobach on 24/05/2021.
//

import Foundation

struct PagedResponse<T: Codable>: Codable {
    let page: Int
    let results: [T]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
