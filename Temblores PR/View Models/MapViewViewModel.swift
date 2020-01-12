//
//  MapViewViewModel.swift
//  Temblores PR
//
//  Created by Eduardo Moll on 1/11/20.
//  Copyright © 2020 eduardo moll. All rights reserved.
//

import Foundation
import CoreLocation

struct EarthquakeAnnotationData {
    let magnitude: String
    let coordinates: CLLocationCoordinate2D
}

struct MapViewViewModel {
    let coordindates: [EarthquakeAnnotationData]
    
    init(magnitude: String, latitude: Double, longitude: Double) {
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let annotationData = EarthquakeAnnotationData(magnitude: magnitude, coordinates: coordinate)
        self.coordindates = [annotationData]
    }
    
    init(coordindates: [EarthquakeAnnotationData]) {
        self.coordindates = coordindates
    }
}
