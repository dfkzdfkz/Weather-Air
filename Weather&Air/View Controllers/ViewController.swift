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
                                     style: .alert) { city in
                                        self.networkManager.fetchRequest(forCity: city, requestType: .weather) { currentState in
                                            if let currentWeather = currentState as? CurrentWeather {
                                                print(currentWeather.cityName)
                                            }
                                        }
                                        self.networkManager.fetchRequest(forCity: city, requestType: .air) { currentState in
                                            if let currentAir = currentState as? CurrentAir {
                                                print(currentAir.aqi)
                                            }
                                        }
        }
        
    }
    
}

