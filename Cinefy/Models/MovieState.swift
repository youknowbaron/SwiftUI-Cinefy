//
//  MovieState.swift
//  Cinefy
//
//  Created by vobach on 21/05/2021.
//

import Foundation

// MARK: - MovieState
struct MovieState: Codable, Identifiable {
    let id: Int
    let favorite, rated, watchlist: Bool
}
