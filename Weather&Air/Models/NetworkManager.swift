//
//  NetworkManager.swift
//  Weather&Air
//
//  Created by Valentina Abramova on 06.07.2020.
//  Copyright © 2020 Valentina Abramova. All rights reserved.
//

import Foundation
import CoreLocation

struct NetworkManager {
    
    enum RequestType {
        case weather(city: String)
        case air(city: String)
        case weatherGEO(latitude: CLLocationDegrees, longitude: CLLocationDegrees)
        case airGEO(latitude: CLLocationDegrees, longitude: CLLocationDegrees)
     }
    
    func fetchRequest(requestType: RequestType, completionHandler: @escaping (CurrentStateProtocol) -> Void ) {
        var urlString = ""
        switch requestType {
        case .weather(let city): urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&apikey=\(apiWeatherKey)&units=metric"
            
        case .air(let city): urlString = "https://api.waqi.info/feed/\(city)/?token=\(apiAirKey)"
            
        case .weatherGEO(let latitude, let longitude): urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&apikey=\(apiWeatherKey)&units=metric"
        
        case .airGEO(let latitude, let longitude): urlString = "https://api.waqi.info/feed/geo:\(latitude);\(longitude)/?token=\(apiAirKey)"
        }
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if let data = data {
                guard let currentState = self.parseJSON(withData: data, requestType: requestType) else { return }
                completionHandler(currentState)
            }
        }
        task.resume()
    }
    
    fileprivate func parseJSON(withData data: Data, requestType: RequestType) -> CurrentStateProtocol? {
        let decoder = JSONDecoder()
        var currentState: CurrentStateProtocol?
        do {
            switch requestType {
            case .weather, .weatherGEO:
                let currentWeatherData = try decoder.decode(CurrentWeatherData.self,
                                                            from: data)
                guard let current = CurrentWeather(currentWeatherData: currentWeatherData) else { return nil }
                currentState = current
            case .air, .airGEO:
                let currentAirData = try decoder.decode(CurrentAirData.self,
                                                        from: data)
                guard let current = CurrentAir(currentAirData: currentAirData) else { return nil }
                currentState = current
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return currentState
    }
    
}
