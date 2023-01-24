//
//  CurrentWeatherData.swift
//  Weather App
//
//  Created by Илья Аношин on 24.01.2023.
//

import Foundation

// Модель для парсинга джейсон запроса


struct CurrentWeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
    
    
}


struct Main: Codable {
    let temp: Double
    let feelsLike: Double
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
    }
}

struct Weather: Codable {
    let id: Int
}
