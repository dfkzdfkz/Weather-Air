//
//  ViewController.swift
//  Weather&Air
//
//  Created by Valentina Abramova on 21.06.2020.
//  Copyright © 2020 Valentina Abramova. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureNowLabel: UILabel!
    @IBOutlet weak var temperatureFeelsLabel: UILabel!
    @IBOutlet weak var airQualityLabel: UILabel!
    
    let networkManager = NetworkManager()
    lazy var locationManager: CLLocationManager = {
        let lm = CLLocationManager()
        lm.delegate = self
        lm.desiredAccuracy = kCLLocationAccuracyKilometer
        lm.requestWhenInUseAuthorization()
        return lm
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestLocation()
        }
    }

    @IBAction func searchButtonPressed(_ sender: UIButton) {
        
        presentSearchAlertController(withTitle: "Enter city name",
                                     message: nil,
                                     style: .alert) { [unowned self] city in
                                        self.networkManager.fetchRequest(requestType: .weather(city: city))  { currentState in
                                            if let currentWeather = currentState as? CurrentWeather {
                                                self.updateInterfaceWith(weather: currentWeather)
                                            }
                                        }
                                        self.networkManager.fetchRequest(requestType: .air(city: city)) { currentState in
                                            if let currentAir = currentState as? CurrentAir {
                                                self.updateInterfaceWith(air: currentAir)
                                            }
                                        }
        }
        
    }
    
    func updateInterfaceWith(weather: CurrentWeather) {
        DispatchQueue.main.async {
            self.cityLabel.text = weather.cityName
            self.temperatureNowLabel.text = weather.temperatureString + " °C"
            self.temperatureFeelsLabel.text = "feels like " + weather.temperatureFeelsLikeString + " °C"
            self.weatherIcon.image = UIImage(systemName: weather.systemIconNameString)
        }
    }
        
    
    func updateInterfaceWith(air: CurrentAir) {
        DispatchQueue.main.async {
            self.airQualityLabel.text = "\(air.aqi) AQI"
        }
    }
    
}

extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        
        self.networkManager.fetchRequest(requestType: .weatherGEO(latitude: latitude, longitude: longitude)) { currentState in
            if let currentWeather = currentState as? CurrentWeather {
                self.updateInterfaceWith(weather: currentWeather)
            }
        }

        self.networkManager.fetchRequest(requestType: .airGEO(latitude: latitude, longitude: longitude)) { currentState in
            if let currentAir = currentState as? CurrentAir {
                self.updateInterfaceWith(air: currentAir)
            }
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
}

