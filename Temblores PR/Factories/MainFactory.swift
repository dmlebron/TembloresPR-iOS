//
//  MainFactory.swift
//  Temblores PR
//
//  Created by Eduardo Moll on 1/11/20.
//  Copyright © 2020 eduardo moll. All rights reserved.
//

import Foundation

class MainFactory {
    
    private let sharedRepository: EarthquakeRepository
    
    init() {
        
        func makeEathquakeService() -> EarthquakeApiService {
            let network = NetworkService(session: .shared)
            let earthquakeService = EarthquakeService(service: network)
            return earthquakeService
        }
        
        func makeEathquakeRepository() -> EarthquakeRepository {
            let earthquakeService = makeEathquakeService()
            let repository = EarthquakeRemoteRepository(service: earthquakeService)
            return repository
        }
        
        self.sharedRepository = makeEathquakeRepository()
    }
    
    func makeSummaryViewModel() -> SummaryViewModel {
        return SummaryViewModel(repository: sharedRepository)
    }
    
    func makeEarthquakeLocationsViewModel() -> EarthquakeLocationsViewModel {
        return EarthquakeLocationsViewModel(repository: sharedRepository)
    }
}
