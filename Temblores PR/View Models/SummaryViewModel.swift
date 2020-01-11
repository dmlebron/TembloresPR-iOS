//
//  SummaryViewModel.swift
//  Temblores PR
//
//  Created by Eduardo Moll on 1/8/20.
//  Copyright © 2020 eduardo moll. All rights reserved.
//

import Foundation
import Combine

class SummaryViewModel: ObservableObject {
    
    @Published private(set) var earthquakes: [Earthquake] = []
    private var subscriber: AnyCancellable?
    
    let earthquakeService: EarthquakeService
    let title: String = "Temblores PR"
    
    init(earthquakeService: EarthquakeService) {
        self.earthquakeService = earthquakeService
    }
    
    func loadSummary(clearsAll: Bool = false) {
        subscriber = earthquakeService.loadEarthQuakes().receive(on: DispatchQueue.main).sinkToResult { result in
            switch result {
            case .success(let earthquakes):
                if clearsAll { self.earthquakes.removeAll() }
                self.earthquakes.append(contentsOf: earthquakes.earthquakes)
            case .failure(let error as NSError):
                print(error.debugDescription)
            }
        }
    }
}
