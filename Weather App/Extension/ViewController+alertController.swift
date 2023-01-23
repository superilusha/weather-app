//
//  ViewController+alertController.swift
//  Weather App
//
//  Created by Илья Аношин on 23.01.2023.
//

import Foundation
import UIKit

//Добавляю во ViewController метод, создающий и вызывающий alertController

extension ViewController {
    
    func presentSearchAlertController (withTitle title: String?, message: String?, style: UIAlertController.Style) {
        
        
        //создаю alert controller
        let ac = UIAlertController(title: title, message: message, preferredStyle: style)
        
        
        //добавляю в него textField. В этом textField будет изначально рандомный элемент из массива
        ac.addTextField { tf in
            let cities = ["San Francisco", "Moscow", "New York", "Stambul", "Viena" ]
            tf.placeholder = cities.randomElement()
        }
        
        let search = UIAlertAction(title: "Search", style: .default) {action in
            let textField = ac.textFields?.first
            guard let cityName = textField?.text else {return}
            if cityName != "" {
                print("search info or the \(cityName)")
            }
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        ac.addAction(search)
        ac.addAction(cancel)
        present(ac, animated: true, completion: nil)
    }
}
