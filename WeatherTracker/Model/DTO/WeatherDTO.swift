//
//  WeatherDTO.swift
//  WeatherTracker
//
//  Created by Wesley Luntsford on 1/4/25.
//

import Foundation

struct WeatherDTO: Decodable {
    let location: LocationDTO
    let current: CurrentWeatherDTO
    
    struct LocationDTO: Decodable {
        let name: String
        let region: String
        let country: String
        let lat: Double
        let lon: Double
        let tz_id: String
        let localtime_epoch: Int
        let localtime: String
    }
    
    struct CurrentWeatherDTO: Decodable {
        let last_updated_epoch: Int
        let last_updated: String
        let tempC: Double
        let tempF: Double
        let isDay: Int
        let condition: ConditionDTO
        let windMph: Double
        let windKph: Double
        let windDegree: Int
        let windDir: String
        let pressureMb: Double
        let pressureIn: Double
        let precipMm: Double
        let precipIn: Double
        let humidity: Int
        let cloud: Int
        let feelslikeC: Double
        let feelslikeF: Double
        let windchillC: Double
        let windchillF: Double
        let heatindexC: Double
        let heatindexF: Double
        let dewpointC: Double
        let dewpointF: Double
        let visKm: Double
        let visMiles: Double
        let uv: Double
        let gustMph: Double
        let gustKph: Double
        
        enum CodingKeys: String, CodingKey {
            case last_updated_epoch
            case last_updated
            case tempC = "temp_c"
            case tempF = "temp_f"
            case isDay = "is_day"
            case condition
            case windMph = "wind_mph"
            case windKph = "wind_kph"
            case windDegree = "wind_degree"
            case windDir = "wind_dir"
            case pressureMb = "pressure_mb"
            case pressureIn = "pressure_in"
            case precipMm = "precip_mm"
            case precipIn = "precip_in"
            case humidity
            case cloud
            case feelslikeC = "feelslike_c"
            case feelslikeF = "feelslike_f"
            case windchillC = "windchill_c"
            case windchillF = "windchill_f"
            case heatindexC = "heatindex_c"
            case heatindexF = "heatindex_f"
            case dewpointC = "dewpoint_c"
            case dewpointF = "dewpoint_f"
            case visKm = "vis_km"
            case visMiles = "vis_miles"
            case uv
            case gustMph = "gust_mph"
            case gustKph = "gust_kph"
        }
        
        struct ConditionDTO: Decodable {
            let icon: String
            
            // Ensures the icon URL is absolute by prepending "https:" if necessary
            var formattedIconURL: URL? {
                if icon.hasPrefix("//") {
                    return URL(string: "https:" + icon)
                }
                return URL(string: icon)
            }
        }
    }
    
    func toWeather() -> Weather {
        return Weather(
            cityName: location.name,
            temperature: Int(current.tempC),
            conditionImageName: current.condition.formattedIconURL,
            humidity: current.humidity,
            uvIndex: Int(current.uv),
            feelsLike: Int(current.feelslikeC)
        )
    }
}
