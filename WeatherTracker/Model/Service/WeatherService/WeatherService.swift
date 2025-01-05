//
//  WeatherService.swift
//  WeatherTracker
//
//  Created by Wesley Luntsford on 1/4/25.
//

import Foundation

protocol WeatherServiceProtocol: Sendable {
    func fetchCurrentWeatherById(cityId: Int) async throws -> Weather
    func searchCities(query: String) async throws -> [City]
    func saveCity(cityId: Int)
    func fetchSavedCityId() -> Int?
}

struct WeatherService: WeatherServiceProtocol {
    static let userDefaultsCityKey = "selectedCity"
    private let networkService: NetworkService
    
    init(networkService: NetworkService = NetworkServiceDefault()) {
        self.networkService = networkService
    }
    
    func fetchCurrentWeatherById(cityId: Int) async throws -> Weather {
        let weatherDTO: WeatherDTO = try await networkService.fetch(.currentWeatherById(id: cityId))
        return weatherDTO.toWeather()
    }
    
    func searchCities(query: String) async throws -> [City] {
        let cityDTOs: [CityDTO] = try await networkService.fetch(.searchCities(query: query))
        return cityDTOs.map { cityDTO in
            return City(id: cityDTO.id, name: cityDTO.name)
        }
    }
    
    func saveCity(cityId: Int) {
        UserDefaults.standard.set(cityId, forKey: Self.userDefaultsCityKey)
    }

    func fetchSavedCityId() -> Int? {
        let cityId = UserDefaults.standard.integer(forKey: Self.userDefaultsCityKey)
        return cityId == 0 ? nil : cityId
    }
}
