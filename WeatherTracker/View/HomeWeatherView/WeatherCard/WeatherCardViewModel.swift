//
//  WeatherCardViewModel.swift
//  WeatherTracker
//
//  Created by Wesley Luntsford on 1/4/25.
//

import Foundation

@MainActor @Observable
final class WeatherCardViewModel {
    private let weatherService: WeatherServiceProtocol
    let city: City
    var weather: Weather?
    
    init(weatherService: WeatherServiceProtocol = WeatherService(), city: City, weather: Weather? = nil) {
        self.weatherService = weatherService
        self.city = city
        self.weather = weather
    }
    
    func fetchWeather() async {
        guard weather == nil else { return }
        
        do {
            weather = try await weatherService.fetchCurrentWeatherById(cityId: city.id)
        } catch {
            // TODO: What do we want to do with error here?
            print(error)
        }
    }
    
    var temperatureText: String {
        if let temperature = weather?.temperature {
            String(temperature) + "°"
        } else {
            ""
        }
    }
}
