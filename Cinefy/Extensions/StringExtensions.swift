//
//  StringExtensions.swift
//  Cinefy
//
//  Created by vobach on 18/05/2021.
//

import Foundation

extension String {
    
    private static let imageUrl = "https://image.tmdb.org/t/p"
    
    /// Must be pass suitable and available quality, e.g. 400, 500,...
    func addImageUrl(quality: Int = 400) -> String {
        return "\(String.imageUrl)/w\(quality)\(self)"
    }
    
}
