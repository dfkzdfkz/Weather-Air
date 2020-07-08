//
//  CurrentWeather.swift
//  Weather&Air
//
//  Created by Valentina Abramova on 06.07.2020.
//  Copyright © 2020 Valentina Abramova. All rights reserved.
//

import Foundation

struct CurrentWeather: CurrentStateProtocol {
    
    let cityName: String
    let temperature: Double
    let temperatureFeelsLike: Double
    let conditionCode: Int
    
    init?(currentWeatherData: CurrentWeatherData) {
        cityName = currentWeatherData.name
        temperature = currentWeatherData.main.temp
        temperatureFeelsLike = currentWeatherData.main.feelsLike
        conditionCode = currentWeatherData.weather[0].id
    }
    
}
