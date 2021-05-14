//
//  Genre.swift
//  Cinefy
//
//  Created by vobach on 13/05/2021.
//

import Foundation

// MARK: - Genre
struct Genre: Codable {
    let id: Int
    let name: String
}

extension Array where Element == Genre {
    func toString() -> String {
        var result = ""
        for i in 0..<self.count {
            result.append(self[i].name)
            result.append(i != self.count - 1 ? ", " : "")
        }
        return result
    }
}
