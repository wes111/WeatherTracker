//
//  MockURLSession.swift
//  WeatherTracker
//
//  Created by Wesley Luntsford on 1/5/25.
//

import Foundation

struct MockURLSession: URLSessionProtocol {
    let mockData: Data?
    let mockResponse: URLResponse?
    
    func data(from url: URL) async throws -> (Data, URLResponse) {

        guard let data = mockData, let response = mockResponse else {
            throw NetworkError.invalidResponse
        }
        return (data, response)
    }
}
