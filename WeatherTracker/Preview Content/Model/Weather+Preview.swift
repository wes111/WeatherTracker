//
//  Weather+Preview.swift
//  WeatherTracker
//
//  Created by Wesley Luntsford on 1/5/25.
//

import Foundation

extension Weather {
    static let preview = Weather(
        cityName: "Paris",
        temperature: 25,
        conditionImageName: URL(string: "https://cdn.weatherapi.com/weather/64x64/day/113.png")!,
        humidity: 45,
        uvIndex: 2,
        feelsLike: 24
    )
}
