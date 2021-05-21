//
//  Account.swift
//  Cinefy
//
//  Created by vobach on 21/05/2021.
//

import Foundation

// MARK: - Account
struct Account: Codable, Identifiable {
    let avatar: Avatar
    let id: Int
    let iso639_1, iso3166_1: String
    let name: String?
    let includeAdult: Bool
    let username: String
    
    var nameTitle: String {
        if let name = name, !name.isEmpty {
            return name
        } else {
            return username
        }
    }

    enum CodingKeys: String, CodingKey {
        case avatar, id
        case iso639_1 = "iso_639_1"
        case iso3166_1 = "iso_3166_1"
        case name
        case includeAdult = "include_adult"
        case username
    }
    
    var json: Data? {
        return try? JSONEncoder().encode(self)
    }
    
    init?(json: Data?) {
        if json != nil, let account = try? JSONDecoder().decode(Account.self, from: json!) {
            self = account
        } else {
            return nil
        }
    }
}

// MARK: - Avatar
struct Avatar: Codable {
    let gravatar: Gravatar
    let tmdb: Tmdb
}

// MARK: - Gravatar
struct Gravatar: Codable {
    let hash: String
}

// MARK: - Tmdb
struct Tmdb: Codable {
    let avatarPath: String?

    enum CodingKeys: String, CodingKey {
        case avatarPath = "avatar_path"
    }
}
