//
//  EarthquakeLocationsView.swift
//  Temblores PR
//
//  Created by Eduardo Moll on 1/11/20.
//  Copyright © 2020 eduardo moll. All rights reserved.
//

import SwiftUI
import MapKit
import Combine

struct EarthquakeLocationsView: View {
    
    @ObservedObject var viewModel: EarthquakeLocationsViewModel
    
    var body: some View {
        MapView(viewModel: MapViewViewModel(coordindates: viewModel.coordinates))
    }
}

struct EarthquakeLocationsView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
//        EarthquakeLocationsView()
    }
}

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
                let coordinates = list.earthquakes.map { quake -> EarthquakeAnnotationData in
                    let latitude: Double = quake.geometry.coordinates[1]
                    let longitude: Double = quake.geometry.coordinates[0]
                    let coordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                    let magnitude = String(format: "%.01f", quake.properties.magnitude)
                    return EarthquakeAnnotationData(magnitude: magnitude, coordinates: coordinates)
                }
                self.coordinates = coordinates
            case .failure(let error):
                print(error)
            }
        }
    }
}
