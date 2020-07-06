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
                                        self.networkManager.fetchWeather(forCity: city)
                                        self.networkManager.fetchAir(forCity: city)
        }
        
    }
    
}
