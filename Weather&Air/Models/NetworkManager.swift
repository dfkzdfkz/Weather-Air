//
//  NetworkManager.swift
//  Weather&Air
//
//  Created by Valentina Abramova on 06.07.2020.
//  Copyright © 2020 Valentina Abramova. All rights reserved.
//

import Foundation

struct NetworkManager {
    
    enum RequestType {
        case weather
        case air
    }
    
    func fetchRequest(forCity city: String, requestType: RequestType) {
        var urlString = ""
        switch requestType {
        case .weather: urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&apikey=\(apiWeatherKey)"
        case .air: urlString = "https://api.waqi.info/feed/\(city)/?token=\(apiAirKey)"
        }
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if let data = data {
                switch requestType {
                case .weather: self.parseJSONWeather(withData: data)
                case .air: self.parseJSONAir(withData: data)
                }
            }
        }
        task.resume()
    }
    
    func parseJSONWeather(withData data: Data) {
        let decoder = JSONDecoder()
        do {
            let currentWeatherData = try decoder.decode(CurrentWeatherData.self,
                                                        from: data)
            print(currentWeatherData.main.temp)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func parseJSONAir(withData data: Data) {
        let decoder = JSONDecoder()
        do {
            let currentWeatherData = try decoder.decode(CurrentAirData.self,
                                                        from: data)
            print(currentWeatherData.data.aqi)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
}
