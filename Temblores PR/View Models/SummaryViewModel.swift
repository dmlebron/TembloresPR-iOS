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
    
    let title: String = "Temblores PR"
    let repository: EarthquakeRepository
    
    init(repository: EarthquakeRepository) {
        self.repository = repository
    }
    
    func loadSummary(clearsAll: Bool = false) {
        subscriber = repository.loadSummary().sinkToResult { result in
            switch result {
            case .success(let earthquakes):
                if clearsAll { self.earthquakes.removeAll() }
                self.earthquakes.append(contentsOf: earthquakes.earthquakes)
            case .failure(let error as NSError):
                print(error.debugDescription)
            }
        }
    }
    
    func sort() {
        self.earthquakes = earthquakes.sorted {
            $0.properties.magnitude > $1.properties.magnitude
        }
    }
}

