//
//  HomeWeatherViewModel.swift
//  WeatherTracker
//
//  Created by Wesley Luntsford on 1/4/25.
//

import Foundation

@MainActor @Observable
final class HomeWeatherViewModel {
    private let weatherService: WeatherServiceProtocol
    var userInputText: String = ""
    var searchText: String = ""
    var state: HomeViewState = .loading
    var showAlert: Bool = false
    
    init(weatherService: WeatherServiceProtocol = WeatherService()) {
        self.weatherService = weatherService
    }
    
    func updateSearchText() {
        searchText = userInputText
    }
    
    func onSelectCity(_ city: City) {
        weatherService.saveCity(cityId: city.id)
        state = .citySelected(city)
        userInputText = ""
    }
    
    func fetchSavedCity() async {
        if let cityid = weatherService.fetchSavedCityId() {
            await fetchWeatherForCity(id: cityid)
        } else {
            state = .noCitySelected
        }
    }
    
    func fetchWeatherForCity(id: Int) async {
        do {
            let weather = try await weatherService.fetchCurrentWeatherById(cityId: id)
            state = .weather(weather)
        } catch {
            // Log error
            state = .error
            showAlert = true
        }
    }
    
    func search() async {
        do {
            state = .loading
            let cities = try await weatherService.searchCities(query: searchText)
            state = cities.isEmpty ? .noCityResults : .cities(cities)
        } catch {
            // Log error
            state = .error
        }
    }
}
