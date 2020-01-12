//
//  EarthquakeLocationsViewModel.swift
//  Temblores PR
//
//  Created by Eduardo Moll on 1/11/20.
//  Copyright © 2020 eduardo moll. All rights reserved.
//

import Foundation
import Combine
import CoreLocation

class EarthquakeLocationsViewModel: ObservableObject {
    
    let repository: EarthquakeRepository
    private var subscriber: AnyCancellable?
    @Published private(set) var coordinates: [EarthquakeAnnotationData] = []
    
    
    init(repository: EarthquakeRepository) {
        self.repository = repository
        loadLocations()
    }
    
    func loadLocations() {
        subscriber = repository.loadSummary().sinkToResult { (result) in
            switch result {
            case .success(let list):
                let coordinates = list.earthquakes.compactMap { quake -> EarthquakeAnnotationData? in
                    guard let coordinate = self.getCoordinates(from: quake.geometry) else { return nil }
                    let coordinates = CLLocationCoordinate2D(latitude: coordinate.latitude,
                                                             longitude: coordinate.longitude)
                    let magnitude = String(format: "%.01f", quake.properties.magnitude)
                    return EarthquakeAnnotationData(magnitude: magnitude, coordinates: coordinates)
                }
                self.coordinates.removeAll()
                self.coordinates = coordinates
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func getCoordinates(from geometry: EarthquakeGeometry) -> (latitude: Double, longitude: Double)? {
        guard geometry.coordinates.count >= 2 else { return nil }
        let latitudeIndex = geometry.coordinates[0] > 0 ? 0 : 1
        let longitudeIndex = geometry.coordinates[0] < 0 ? 0 : 1
        return (latitude: geometry.coordinates[latitudeIndex],
                longitude: geometry.coordinates[longitudeIndex])
    }
}
