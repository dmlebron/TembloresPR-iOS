//
//  ContentView.swift
//  Temblores PR
//
//  Created by Eduardo Moll on 1/7/20.
//  Copyright © 2020 eduardo moll. All rights reserved.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    let network = NetworkService(session: .shared)
    
    @ObservedObject private var viewModel: SummaryViewModel
    
    init(viewModel: SummaryViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            List(viewModel.earthquakes, id: \.id) { earthquake in
                NavigationLink(destination: MapView(latitude: earthquake.geometry.coordinates[1], longitude: earthquake.geometry.coordinates[0])) {
                    HStack {
                        //                Text(String(describing: earthquake.properties.magnitude))
                        //                    .frame(width: 40)
                        //                    .font(.title)
                        //
                        VStack(alignment: .leading, spacing: 8) {
                            Text(earthquake.properties.place)
                                .font(.body)
                            
                            Text(self.viewModel.dateString(for: earthquake.properties.time))
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
            .navigationBarTitle("Teamblores PR")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentView(viewModel: SummaryViewModel(earthquakeService:
            EarthquakeService(service: NetworkService(session: .shared))
        ))
    }
}

class SummaryViewModel: ObservableObject {
    
    @Published private(set) var earthquakes: [Earthquake] = []
    private var subscriber: AnyCancellable?
    
    let earthquakeService: EarthquakeService
    
    init(earthquakeService: EarthquakeService) {
        self.earthquakeService = earthquakeService
        loadSummary()
    }
    
    private func loadSummary() {
        subscriber = earthquakeService.loadEarthQuakes().receive(on: DispatchQueue.main).sinkToResult { result in
            switch result {
            case .success(let earthquakes):
                self.earthquakes = earthquakes.earthquakes
            case .failure(let error as NSError):
                print(error.debugDescription)
            }
        }
    }
    
    func dateString(for timeInterval: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: timeInterval/1000)
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy h:mm"
        return formatter.string(from: date)
    }
}
