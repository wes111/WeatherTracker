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

protocol URLSessionProtocol: Sendable {
    func data(from url: URL) async throws -> (Data, URLResponse)
}

protocol JSONDecoderProtocol: Sendable {
    func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T
}

struct NetworkServiceDefault: NetworkService {
    private let session: URLSessionProtocol
    private let decoder: JSONDecoderProtocol
    
    init(session: URLSessionProtocol = URLSession.shared, decoder: JSONDecoderProtocol = JSONDecoder()) {
        self.session = session
        self.decoder = decoder
    }
    
    func fetch<T: Decodable>(_ endpoint: WeatherAPIEndpoint) async throws -> T {
        guard let url = endpoint.url else {
            throw NetworkError.invalidURL
        }
        
        let (data, response) = try await session.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.invalidStatusCode(httpResponse.statusCode)
        }
        
        return try decoder.decode(T.self, from: data)
    }
}

