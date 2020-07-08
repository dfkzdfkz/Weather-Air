//
//  CurrentAir.swift
//  Weather&Air
//
//  Created by Valentina Abramova on 06.07.2020.
//  Copyright © 2020 Valentina Abramova. All rights reserved.
//

import Foundation

struct CurrentAir: CurrentStateProtocol {
    let aqi: Int
    
    init?(currentAirData: CurrentAirData) {
        aqi = currentAirData.data.aqi
    }
}
