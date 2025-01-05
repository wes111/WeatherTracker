//
//  NetworkService.swift
//  WeatherTracker
//
//  Created by Wesley Luntsford on 1/4/25.
//


import Foundation

protocol NetworkService: Sendable {
    func fetch<T: Decodable>(_ endpoint: WeatherAPIEndpoint) async throws -> T
}

struct NetworkServiceDefault: NetworkService {
    
    func fetch<T: Decodable>(_ endpoint: WeatherAPIEndpoint) async throws -> T {
        guard let url = endpoint.url else {
            throw NetworkError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.invalidStatusCode(httpResponse.statusCode)
        }
        
        return try JSONDecoder().decode(T.self, from: data)
    }
}
