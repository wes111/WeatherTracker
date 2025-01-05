//
//  Weather.swift
//  WeatherTracker
//
//  Created by Wesley Luntsford on 1/4/25.
//

import Foundation

struct Weather: Equatable {
    var cityName: String
    var temperature: Int
    var conditionImageName: URL?
    var humidity: Int
    var uvIndex: Int
    var feelsLike: Int
}
