//
//  ResultState.swift
//  Cinefy
//
//  Created by vobach on 13/05/2021.
//

import Foundation

enum ResultState<Data> where Data: Codable {
    case loading
    case success(data: Data)
    case failed(error: Error)
}


