//
//  Cast.swift
//  Cinefy
//
//  Created by vobach on 18/05/2021.
//

import Foundation

// MARK: - Cast
struct Cast: Codable, Identifiable {
    let adult: Bool
    let gender, id: Int
    let knownForDepartment, name: String
    let originalName: String?
    let popularity: Double
    let profilePath: String?
    let castID: Int?
    let character, creditID: String?
    let order: Int?
    
    let alsoKnownAs: [String]?
    let biography, deathday, birthday: String?
    let placeOfBirth: String?

    enum CodingKeys: String, CodingKey {
        case adult, gender, id
        case knownForDepartment = "known_for_department"
        case name
        case originalName = "original_name"
        case popularity
        case profilePath = "profile_path"
        case castID = "cast_id"
        case character
        case creditID = "credit_id"
        case order
        case alsoKnownAs = "also_known_as"
        case biography, deathday, birthday
        case placeOfBirth = "place_of_birth"
    }
}
