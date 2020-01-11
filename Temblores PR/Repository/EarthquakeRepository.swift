//
//  EarthquakeRepository.swift
//  Temblores PR
//
//  Created by Eduardo Moll on 1/10/20.
//  Copyright © 2020 eduardo moll. All rights reserved.
//

import Foundation
import Combine

protocol EarthquakeRepository {
    func loadSummary() -> AnyPublisher<EarthquakeList, Error>
}

struct EarthquakeRemoteRepository: EarthquakeRepository {

    // Make this a protocol type
    let service: EarthquakeService
    
    init(service: EarthquakeService) {
        self.service = service
    }
    
    func loadSummary() -> AnyPublisher<EarthquakeList, Error> {
        return service.loadEarthQuakes()
    }
}
