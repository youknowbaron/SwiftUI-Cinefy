//
//  ProductionCountry.swift
//  Cinefy
//
//  Created by vobach on 13/05/2021.
//

import Foundation

// MARK: - ProductionCountry
struct ProductionCountry: Codable {
    let iso3166_1, name: String

    enum CodingKeys: String, CodingKey {
        case iso3166_1 = "iso_3166_1"
        case name
    }
}

extension Array where Element == ProductionCountry {
    func toString() -> String {
        var result = ""
        for i in 0..<self.count {
            result.append(self[i].iso3166_1)
            result.append(i != self.count - 1 ? ", " : "")
        }
        return result
    }
}
