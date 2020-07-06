//
//  CurrentAirData.swift
//  Weather&Air
//
//  Created by Valentina Abramova on 06.07.2020.
//  Copyright © 2020 Valentina Abramova. All rights reserved.
//

import Foundation

struct CurrentAirData: Codable {
    let data: DataClass
}

struct DataClass: Codable {
    let aqi: Int
}
