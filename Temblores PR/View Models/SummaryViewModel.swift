//
//  SummaryViewModel.swift
//  Temblores PR
//
//  Created by Eduardo Moll on 1/8/20.
//  Copyright © 2020 eduardo moll. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class SummaryViewModel: ObservableObject {
    
    @Published private(set) var viewState: ViewState
    @Published private(set) var earthquakes: [Earthquake] = []
    
    private let repository: EarthquakeRepository
    private var subscriber: AnyCancellable?
    
    let title: String = "Temblores PR"

    init(repository: EarthquakeRepository) {
        self.repository = repository
        viewState = .error
    }
    
    func loadSummary(clearsAll: Bool = false) {
        self.viewState = .loading
        subscriber = repository.loadSummary().sinkToResult { result in
            switch result {
            case .success(let earthquakes):
                if clearsAll { self.earthquakes.removeAll() }
                self.earthquakes.append(contentsOf: earthquakes.earthquakes)
                self.viewState = .loaded
            case .failure(let error as NSError):
                self.viewState = .error
                print(error.debugDescription)
            }
        }
    }
    
    func sort(by sortmode: SortMode) {
        self.earthquakes = earthquakes.sorted {
            switch sortmode {
            case .date:
                return $0.properties.time > $1.properties.time
            case .magnitude:
                return $0.properties.magnitude > $1.properties.magnitude
            }
        }
    }
}

