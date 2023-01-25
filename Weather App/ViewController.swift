//
//  ViewController.swift
//  Weather App
//
//  Created by Илья Аношин on 20.01.2023.
//

import UIKit

class ViewController: UIViewController {
    
    // Привязываю аутлеты элементов
    
    @IBOutlet weak var weatherIconImageView: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var feelsLikeTemperatureLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    var networkWeatherManager = NetworkWeatherManager()
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkWeatherManager.onCompletion = { [weak self] currentWeather in
            guard let self = self else {return}
            self.updateInterfaceWith(weather: currentWeather)
        }
        networkWeatherManager.fetchCurrentWeather(forCity: "Moscow")
        
    
        
    }
    
    
    // функция для изменения элементов интерфейса. Исполнение функции в главном потоке
    func updateInterfaceWith(weather: CurrentWeather) {
        
        DispatchQueue.main.async {
            self.cityLabel.text = weather.cityName
            self.temperatureLabel.text = weather.temperatureString
            self.feelsLikeTemperatureLabel.text = weather.feelsLikeTemperatureString
            self.weatherIconImageView.image = UIImage(systemName: weather.systemIconNameString)
        }
    }
    
    
    
    
    // привязываю аутлет кнопки и вешаю на нее алерт
    @IBAction func searchPressed(_ sender: UIButton) {
        self.presentSearchAlertController(withTitle: "Enter city name", message: nil, style: .alert) { [unowned self] city in
            self.networkWeatherManager.fetchCurrentWeather(forCity: city)
        }
    }
    


}

