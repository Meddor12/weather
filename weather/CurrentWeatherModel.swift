//
//  CurrentWeatherModel.swift
//  weather
//
//  Created by Meddor on 19.02.2023.
//

import Foundation
struct CurrentWeatherModel {
    let id: Int
    let cityName: String
    let description: String
    let feelsLike: Double
    let temp: Double
    let min: Double
    let max: Double
    
    var icon: String {
        switch id {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
}
