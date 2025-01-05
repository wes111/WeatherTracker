//
//  WeatherAPIEndpoint.swift
//  WeatherTracker
//
//  Created by Wesley Luntsford on 1/4/25.
//

import Foundation

enum WeatherAPIEndpoint {
    case searchCities(query: String)
    case currentWeatherById(id: Int)
    
    private var path: String {
        switch self {
        case .searchCities:
            return "/v1/search.json"
        case .currentWeatherById:
            return "/v1/current.json"
        }
    }
    
    private struct QueryKeys {
        static let key = "key"
        static let query = "q"
    }
    
    private var scheme: String {
        return "https"
    }
    
    private var host: String {
        return "api.weatherapi.com"
    }
    
    private var queryItems: [URLQueryItem] {
        switch self {
        case .searchCities(let query):
            return [
                URLQueryItem(name: QueryKeys.key, value: "a58519d8e9de40a4942150231250401"),
                URLQueryItem(name: QueryKeys.query, value: query)
            ]
        case .currentWeatherById(let id):
            return [
                URLQueryItem(name: QueryKeys.key, value: "a58519d8e9de40a4942150231250401"),
                URLQueryItem(name: QueryKeys.query, value: "id:" + String(id))
            ]
        }
    }
    
    var url: URL? {
        var urlComponent = URLComponents()
        urlComponent.host = host
        urlComponent.scheme = scheme
        urlComponent.path = path
        urlComponent.queryItems = queryItems
        return urlComponent.url
    }
}
