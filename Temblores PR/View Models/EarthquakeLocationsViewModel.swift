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
    
    @Published private(set) var viewState: ViewState
    @Published private(set) var annotationData: [EarthquakeAnnotationData] = []
    private var subscriber: AnyCancellable?
    
    let repository: EarthquakeRepository
    
    init(repository: EarthquakeRepository) {
        self.repository = repository
        self.viewState = .loading
        loadLocations()
    }
    
    func loadLocations() {
        self.viewState = .loading
        subscriber = repository.loadSummary().sinkToResult { (result) in
            switch result {
            case .success(let list):
                let annotationData = self.getAnnotationData(from: list)
                self.annotationData.removeAll()
                self.annotationData = annotationData
                self.viewState = .loaded
            case .failure(let error):
                self.viewState = .error
                print(error)
            }
        }
    }
    
    private func getAnnotationData(from list: EarthquakeList) -> [EarthquakeAnnotationData] {
         return list.earthquakes.compactMap { quake -> EarthquakeAnnotationData? in
            guard let coordinate = self.getCoordinates(from: quake.geometry) else { return nil }
            let coordinates = CLLocationCoordinate2D(latitude: coordinate.latitude,
                                                     longitude: coordinate.longitude)
            let magnitude = String(format: "%.01f", quake.properties.magnitude)
            return EarthquakeAnnotationData(magnitude: magnitude, coordinates: coordinates)
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
