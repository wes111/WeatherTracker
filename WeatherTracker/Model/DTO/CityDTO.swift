//
//  CityDTO.swift
//  WeatherTracker
//
//  Created by Wesley Luntsford on 1/4/25.
//

import Foundation

struct CityDTO: Decodable {
    let id: Int
    let name: String
    let region: String
    let country: String
    let lat: Double
    let lon: Double
    let url: String
    
    func toCity() -> City {
        .init(id: id, name: name)
    }
}
