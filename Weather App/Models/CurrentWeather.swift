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
        return "\(temperature.rounded())"
    }
    
    let feelsLikeTemperature: Double
    //вычисляемое свойство для перевода типа данных
    var feelsLikeTemperatureString: String {
        return "\(feelsLikeTemperature.rounded())"
    }
    
    let conditionCode: Int
    
    // фейлэйбл инициализатор, которые позволит распарсить данные из модели currentWeatherData в экземпляр класса currentWeather
    init?(currentWeatherData: CurrentWeatherData) {
        cityName = currentWeatherData.name
        temperature = currentWeatherData.main.temp
        feelsLikeTemperature = currentWeatherData.main.feelsLike
        conditionCode = currentWeatherData.weather.first!.id
    }
}
