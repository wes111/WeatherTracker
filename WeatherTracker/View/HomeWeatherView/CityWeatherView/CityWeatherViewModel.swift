//
//  CityWeatherViewModel.swift
//  WeatherTracker
//
//  Created by Wesley Luntsford on 1/5/25.
//

import Foundation

struct CityWeatherViewModel {
    let weather: Weather
    
    var cityName: String {
        weather.cityName
    }
    
    var temperatureText: String {
        "\(weather.temperature)°"
    }
    
    var conditionImageName: URL? {
        weather.conditionImageName
    }
    
    var humidityText: String {
        "\(weather.humidity)%"
    }
    
    var uvIndexText: String {
        "\(weather.uvIndex)"
    }
    
    var feelsLikeText: String {
        "\(weather.feelsLike)°"
    }
}
