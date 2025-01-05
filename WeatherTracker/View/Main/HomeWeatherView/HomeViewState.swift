//
//  HomeViewState.swift
//  WeatherTracker
//
//  Created by Wesley Luntsford on 1/4/25.
//

import Foundation

enum HomeViewState: Equatable {
    case loading
    case noCityResults
    case noCitySelected
    case weather(Weather)
    case cities([City])
    case error
    case citySelected(City)
}
