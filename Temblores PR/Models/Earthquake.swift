//
//  Earthquake.swift
//  Temblores PR
//
//  Created by Eduardo Moll on 1/7/20.
//  Copyright © 2020 eduardo moll. All rights reserved.
//

import Foundation

struct EarthquakeList: Codable {
    let earthquakes: [Earthquake]
    
    enum CodingKeys: String, CodingKey {
        case earthquakes = "features"
    }
}

struct Earthquake: Codable {
    let id: String
    let properties: EarthquakeProperties
    let geometry: EarthquakeGeometry
}

struct EarthquakeProperties: Codable {
    let alert: String?
    let magnitude: Double
    let place: String
    let time: TimeInterval
    let title: String
    let intensity: Double?
    
    enum CodingKeys: String, CodingKey {
        case alert
        case magnitude = "mag"
        case place
        case time
        case title
        case intensity = "cdi"
        
    }
}
