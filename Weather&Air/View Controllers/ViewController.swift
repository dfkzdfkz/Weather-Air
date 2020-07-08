//
//  ViewController.swift
//  Weather&Air
//
//  Created by Valentina Abramova on 21.06.2020.
//  Copyright © 2020 Valentina Abramova. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureNowLabel: UILabel!
    @IBOutlet weak var temperatureFeelsLabel: UILabel!
    @IBOutlet weak var airQualityLabel: UILabel!
    
    let networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func searchButtonPressed(_ sender: UIButton) {
        
        presentSearchAlertController(withTitle: "Enter city name",
                                     message: nil,
                                     style: .alert) { [unowned self] city in
                                        self.networkManager.fetchRequest(forCity: city, requestType: .weather) { currentState in
                                            if let currentWeather = currentState as? CurrentWeather {
                                                self.updateInterfaceWith(weather: currentWeather)
                                            }
                                        }
                                        self.networkManager.fetchRequest(forCity: city, requestType: .air) { currentState in
                                            if let currentAir = currentState as? CurrentAir {
                                                self.updateInterfaceWith(air: currentAir)
                                            }
                                        }
        }
        
    }
    
    func updateInterfaceWith(weather: CurrentWeather) {
        DispatchQueue.main.async {
            self.cityLabel.text = weather.cityName
            self.temperatureNowLabel.text = "t " + weather.temperatureString + " °C"
            self.temperatureFeelsLabel.text = "t feels like " + weather.temperatureFeelsLikeString + " °C"
            self.weatherIcon.image = UIImage(systemName: weather.systemIconNameString)
        }
    }
        
    
    func updateInterfaceWith(air: CurrentAir) {
        DispatchQueue.main.async {
            self.airQualityLabel.text = "\(air.aqi) AQI"
        }
    }
    
}

