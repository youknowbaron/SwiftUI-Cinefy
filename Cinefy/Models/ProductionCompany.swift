//
//  ProductionCompany.swift
//  Cinefy
//
//  Created by vobach on 13/05/2021.
//

import Foundation

// MARK: - ProductionCompany
struct ProductionCompany: Codable, Identifiable {
    let id: Int
    let logoPath: String?
    let name, originCountry: String

    enum CodingKeys: String, CodingKey {
        case id
        case logoPath = "logo_path"
        case name
        case originCountry = "origin_country"
    }
}
