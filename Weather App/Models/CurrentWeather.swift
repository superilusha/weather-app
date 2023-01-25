//
//  CurrentWeather.swift
//  Weather App
//
//  Created by Илья Аношин on 24.01.2023.
//

import Foundation

//Создаю модель для дальнейшей интеграции с интерфейсом

struct CurrentWeather {
    let cityName: String
    
    let temperature: Double
    //вычисляемое свойство для перевода типа данных
    var temperatureString: String {
        return String(format: "%.0f", temperature)
    }
    
    let feelsLikeTemperature: Double
    //вычисляемое свойство для перевода типа данных
    var feelsLikeTemperatureString: String {
        return String(format: "%.0f", feelsLikeTemperature)
    }
    
    let conditionCode: Int
    
    
    var systemIconNameString: String {
        switch conditionCode {
        case 200...232:
            return "cloud.bolt.rain.fill"
        case 300...321:
            return "cloud.drizzle.fill"
        case 500...531:
            return "cloud.rain.fill"
        case 600...622:
            return "cloud.snow.fill"
        case 701...781:
            return "smoke.fill"
        case 800:
            return "sun.max.fill"
        case 801...804:
            return "cloud.fill"
        default:
            return "nosign"
        }
    }
    
    // фейлэйбл инициализатор, которые позволит распарсить данные из модели currentWeatherData в экземпляр класса currentWeather
    init?(currentWeatherData: CurrentWeatherData) {
        cityName = currentWeatherData.name
        temperature = currentWeatherData.main.temp
        feelsLikeTemperature = currentWeatherData.main.feelsLike
        conditionCode = currentWeatherData.weather.first!.id
    }
}
