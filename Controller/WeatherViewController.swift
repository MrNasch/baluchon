//
//  WeatherViewController.swift
//  Baluchon
//
//  Created by Nasch on 21/03/2019.
//  Copyright © 2019 Nasch. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {

    // outlet
    @IBOutlet weak var newYorkLabel: UILabel!
    @IBOutlet weak var newYorkCurrentWeatherState: UILabel!
    @IBOutlet weak var newYorkTempLabel: UILabel!
    @IBOutlet weak var hannutLabel: UILabel!
    @IBOutlet weak var hannutCurrentWeatherState: UILabel!
    @IBOutlet weak var hannutTempLabel: UILabel!
    
    override func viewDidLoad() {
        showWeather()
    }
    // update screen with result
    private func update(weatherCity: WeatherCity) {
        newYorkLabel.text = weatherCity.list[1].name
        newYorkCurrentWeatherState.text = weatherCity.list[1].weather[0].description
        newYorkTempLabel.text = "\(Int(round(weatherCity.list[1].main.temp)))°C"
        hannutLabel.text = weatherCity.list[0].name
        hannutCurrentWeatherState.text = weatherCity.list[0].weather[0].description
        hannutTempLabel.text = "\(Int(round(weatherCity.list[0].main.temp)))°C"
        
    }
    // get result from API request
    func showWeather() {
        WeatherService.shared.getWeather { (succes, weatherCity) in
            if succes, let weatherCity = weatherCity {
                self.update(weatherCity: weatherCity)
            } else {
                self.presentAlert()
            }
        }
    }
    // pop alert 
    private func presentAlert() {
        let alertVC = UIAlertController(title: "Error", message: "API data donwload failed", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}
