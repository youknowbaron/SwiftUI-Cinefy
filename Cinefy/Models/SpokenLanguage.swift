//
//  SpokenLanguage.swift
//  Cinefy
//
//  Created by vobach on 13/05/2021.
//

import Foundation

// MARK: - SpokenLanguage
struct SpokenLanguage: Codable {
    let englishName, iso639_1, name: String

    enum CodingKeys: String, CodingKey {
        case englishName = "english_name"
        case iso639_1 = "iso_639_1"
        case name
    }
}

extension Array where Element == SpokenLanguage {
    func toString() -> String {
        var result = ""
        for i in 0..<self.count {
            result.append(self[i].englishName)
            result.append(i != self.count - 1 ? ", " : "")
        }
        return result
    }
}
