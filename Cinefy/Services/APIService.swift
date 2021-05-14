//
//  APIService.swift
//  Cinefy
//
//  Created by vobach on 13/05/2021.
//

import Foundation
import Combine

protocol APIService {
    func request<Response: Codable>(_ endpoint: CinefyApi, dataType: Response.Type) -> AnyPublisher<Response, APIError>
}

struct APIServiceImpl: APIService {
    func request<Response: Codable>(_ endpoint: CinefyApi, dataType: Response.Type) -> AnyPublisher<Response, APIError> {
        return URLSession.shared
            .dataTaskPublisher(for: endpoint.urlRequest)
            .receive(on: DispatchQueue.main)
            .mapError { _ in APIError.unknown }
            .flatMap { data, response -> AnyPublisher<Response, APIError> in
                guard let response = response as? HTTPURLResponse else {
                    return Fail(error: APIError.unknown).eraseToAnyPublisher()
                }
                
                if response.statusCode >= 200 && response.statusCode <= 299 {
                    return Just(data)
                        .decode(type: dataType, decoder: JSONDecoder())
                        .mapError { _ in APIError.decodingError}
                        .eraseToAnyPublisher()
                } else {
                    return Fail(error: APIError.errorCode(response.statusCode))
                        .eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }
    
    
}
