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
        
        networkWeatherManager.fetchCurrentWeather(forCity: "Moscow")
        
    }
    
    
    
    // привязываю аутлет кнопки и вешаю на нее алерт
    @IBAction func searchPressed(_ sender: UIButton) {
        self.presentSearchAlertController(withTitle: "Enter city name", message: nil, style: .alert) { city in
            self.networkWeatherManager.fetchCurrentWeather(forCity: city)
            
        }
    }
    


}

