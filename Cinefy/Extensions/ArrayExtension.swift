//
//  ArrayExtension.swift
//  Cinefy
//
//  Created by vobach on 19/05/2021.
//

import Foundation

extension Array where Element == Movie {
    func onlyAvailableImage() -> [Movie] {
        self.filter { $0.posterPath != nil }
    }
    
    
}

extension Array {
    mutating func limitCount(int: Int = 5) {
        if self.count > 5 {
            self.removeLast(self.count - 5)
        }
    }
}
