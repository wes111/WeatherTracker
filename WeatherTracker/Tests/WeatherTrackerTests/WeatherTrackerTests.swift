//
//  WeatherTrackerTests.swift
//  WeatherTrackerTests
//
//  Created by Wesley Luntsford on 1/4/25.
//

import Testing
@testable import WeatherTracker

import Foundation

@Suite(.serialized) struct WeatherTrackerTests {
    static let endpoint = WeatherAPIEndpoint.searchCities(query: "London")
    let session: MockURLSession = .init(
        mockData: """
        [
            {
                "id": 1,
                "name": "London",
                "region": "England",
                "country": "United Kingdom",
                "lat": 51.509865,
                "lon": -0.118092,
                "url": "london"
            }
        ]
        """.data(using: .utf8)!,
        mockResponse:  HTTPURLResponse(url: endpoint.url!, statusCode: 200, httpVersion: nil, headerFields: nil)
    )
    let networkService: NetworkService
    let weatherService: WeatherServiceProtocol
    
    init() {
        networkService = NetworkServiceDefault(session: session)
        weatherService = WeatherService(networkService: networkService)
    }
    
    @Test func testWeatherAPIEndpointUrl() async throws {
        let endpoint = WeatherAPIEndpoint.searchCities(query: "London")
        guard let url = endpoint.url else {
            Issue.record("Expected valid URL, but got nil")
            return
        }
        
        #expect(url.host == "api.weatherapi.com")
        #expect(url.scheme == "https")
        #expect(url.path == "/v1/search.json")
        #expect(url.query?.contains("q=London") ?? false)
        
        let weatherEndpoint = WeatherAPIEndpoint.currentWeatherById(id: 123)
        guard let weatherUrl = weatherEndpoint.url else {
            Issue.record("Expected valid URL, but got nil")
            return
        }
        
        #expect(weatherUrl.host == "api.weatherapi.com")
        #expect(weatherUrl.scheme == "https")
        #expect(weatherUrl.path == "/v1/current.json")
        #expect(weatherUrl.query?.contains("q=id:123") ?? false)
    }
    
    @Test func testFetchSavedCityId() {
        weatherService.saveCity(cityId: 123)
        UserDefaults.standard.set(123, forKey: WeatherService.userDefaultsCityKey)
        let savedCityId = weatherService.fetchSavedCityId()
        #expect(savedCityId == 123)
    }
    
    @Test func testFetchSavedCityIdReturnsNilWhenNotSet() {
        UserDefaults.standard.removeObject(forKey: WeatherService.userDefaultsCityKey)
        let savedCityId = weatherService.fetchSavedCityId()
        #expect(savedCityId == nil)
    }
    
    @Test func testFetchReturnsDecodedCities() async throws {
        let result: [CityDTO] = try await networkService.fetch(Self.endpoint)
        let cities = result.map { $0.toCity() }
        
        #expect(cities.count == 1)
        #expect(cities.first?.id == 1)
        #expect(cities.first?.name == "London")
    }
}
