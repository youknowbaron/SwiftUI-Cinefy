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
    
    private func log(request: URLRequest){

        let urlString = request.url?.absoluteString ?? ""
        let components = NSURLComponents(string: urlString)

        let method = request.httpMethod != nil ? "\(request.httpMethod!)": ""
        let path = "\(components?.path ?? "")"
        let query = "\(components?.query ?? "")"
        let host = "\(components?.host ?? "")"

        var requestLog = "\n---------- OUT ---------->\n"
        requestLog += "\(urlString)"
        requestLog += "\n\n"
        requestLog += "\(method) \(path)?\(query) HTTP/1.1\n"
        requestLog += "Host: \(host)\n"
        for (key,value) in request.allHTTPHeaderFields ?? [:] {
            requestLog += "\(key): \(value)\n"
        }
        if let body = request.httpBody{
            let bodyString = NSString(data: body, encoding: String.Encoding.utf8.rawValue) ?? "Can't render body; not utf8 encoded";
            requestLog += "\n\(bodyString)\n"
        }

        requestLog += "\n------------------------->\n";
        print(requestLog)
    }
    
    func request<Response: Codable>(_ endpoint: CinefyApi, dataType: Response.Type) -> AnyPublisher<Response, APIError> {
        
        log(request: endpoint.urlRequest)
        
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
                    let json = try? JSONDecoder().decode(MessageResponse.self, from: data)
                    return Fail(error: APIError.errorCode(response.statusCode, json?.statusMessage ?? "Unknown Error"))
                        .eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }
    
    
}
