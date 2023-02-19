//
//  WeatherDataDecod.swift
//  weather
//
//  Created by Meddor on 19.02.2023.
//

import Foundation

struct BaseWeatherModel: Codable {
    let name: String?
    let main: WeatherMainInformation?
    let weather: [Weather?]
}
struct WeatherMainInformation: Codable {
    let temp: Double?
    let temp_min: Double?
    let temp_max:Double
    let feels_like: Double?
}
struct Weather: Codable {
    let id: Int?
    let description: String?
}
