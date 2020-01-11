//
//  EarthquakeViewViewModel.swift
//  Temblores PR
//
//  Created by Eduardo Moll on 1/10/20.
//  Copyright © 2020 eduardo moll. All rights reserved.
//

import Foundation

struct EarthquakeViewViewModel {
    
    let magnitudeString: String
    let magnitudeEnergy: EarthquakeEnergy
    let place: String
    let dateString: String
    
    init(earthquake: Earthquake) {
        self.magnitudeString = EarthquakeViewViewModel.magnitudeString(from: earthquake.properties.magnitude)
        self.magnitudeEnergy = EarthquakeViewViewModel.earthquakeEnergy(for: earthquake.properties.magnitude)
        self.place = earthquake.properties.place
        self.dateString = EarthquakeViewViewModel.dateString(from: earthquake.properties.time)
    }
    
    private static func magnitudeString(from magnitude: Double) -> String {
        return String(format: "%.01f", magnitude)
    }
    
    private static func earthquakeEnergy(for magnitude: Double) -> EarthquakeEnergy {
        if magnitude < 4 {
            return .small
        } else if magnitude >= 4 && magnitude < 6 {
            return .moderate
        } else if magnitude >= 6 && magnitude < 8 {
            return .major
        } else {
            return .great
        }
    }
    
    private static func dateString(from timeInterval: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: timeInterval/1000)
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd, yyyy h:mm a"
        formatter.timeZone = TimeZone(abbreviation: "AST")
        return formatter.string(from: date)
    }
}
