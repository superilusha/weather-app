//
//  NetworkWeatherManager.swift
//  Weather App
//
//  Created by Илья Аношин on 23.01.2023.
//

import Foundation
import CoreLocation

//Создаю class-менеджер с методом для создания сесии и получения json-файла

class NetworkWeatherManager {
    
    enum RequestType{
        
        case cityName(city: String)
        case coordinate(latitude: CLLocationDegrees, longitude: CLLocationDegrees)
        
    }
    
    var onCompletion: ((CurrentWeather) -> Void)?
    
    
    func fetchCurrentWeather(forRequestType requestType: RequestType) {
        var urlString = ""
        switch requestType {
        case .cityName(let city):
            urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)&units=metric"
        case .coordinate(let latitude, let longitude):
            urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&units=metric"
        }
        
        performRequest(withURLString: urlString)
    }
    
//    // получение информации по названию города
//    func fetchCurrentWeather(forCity city: String) {
//        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)&units=metric"
//
//        performRequest(withURLString: urlString)
//    }
//
//    // получение информации по широте и долготе
//
//    func fetchCurrentWeather(forLatitude latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
//        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&units=metric"
//        performRequest(withURLString: urlString)
//    }
        
    // Общий метод
        
    fileprivate func performRequest(withURLString urlString: String) {
        guard let url = URL(string: urlString) else {return}
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if let data = data{
                if let currentWeather = self.parseJson(withData: data) {
                    self.onCompletion?(currentWeather)
                }
            }
        }
        task.resume()
    }
    
    
    // метод для парсинга json-файла в модель CurrentWeatherData
    fileprivate func parseJson(withData data: Data) -> CurrentWeather? {
        let decoder = JSONDecoder()
        do {
            let currentWeatherData = try decoder.decode(CurrentWeatherData.self, from: data)
            guard let currentWaether = CurrentWeather.init(currentWeatherData: currentWeatherData) else {return nil}
            return currentWaether
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
    }
}
