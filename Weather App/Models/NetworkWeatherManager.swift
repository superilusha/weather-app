//
//  NetworkWeatherManager.swift
//  Weather App
//
//  Created by Илья Аношин on 23.01.2023.
//

import Foundation

//Создаю class-менеджер с методом для создания сесии и получения json-файла

class NetworkWeatherManager {
    
    var onCompletion: ((CurrentWeather) -> Void)?
    
    
    func fetchCurrentWeather(forCity city: String) {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)&units=metric"
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
    func parseJson(withData data: Data) -> CurrentWeather? {
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
