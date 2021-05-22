//
//  PeopleResponse.swift
//  Cinefy
//
//  Created by vobach on 21/05/2021.
//

import Foundation

struct PeopleResponse: Codable {
    let page: Int
    let results: [Cast]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
