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
                NavigationLink(destination: DetailView(viewModel: DetailViewModel(earthquake: earthquake))) {
                    EarthquakeView(viewModel: EarthquakeViewViewModel(earthquake: earthquake))
                        .padding(.vertical, 8)
                }
            }
            .navigationBarTitle(self.viewModel.title)
            .onAppear { self.viewModel.loadSummary() } 
        }
    }
    
    func load() {
        self.viewModel.loadSummary(clearsAll: true)
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentView(viewModel: SummaryViewModel(earthquakeService:
            EarthquakeService(service: NetworkService(session: .shared))
        ))
    }
}

struct EarthquakeView: View {
    
    let viewModel: EarthquakeViewViewModel
    
    var body: some View {
        HStack {
            Text(viewModel.magnitudeString)
                .font(.title)
                .fontWeight(.bold)
                .frame(width: 60)
                .foregroundColor(viewModel.magnitudeEnergy.color)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(viewModel.place)
                    .font(.body)
                
                Text(viewModel.dateString)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
    }
}

struct EarthquakeViewViewModel {
    
    let magnitudeString: String
    let magnitudeEnergy: EarthquakeEnergy
    let place: String
    let dateString: String
    
    init(earthquake: Earthquake) {
        self.magnitudeString = EarthquakeViewViewModel.magnitudeString(from: earthquake.properties.magnitude)
        self.magnitudeEnergy = EarthquakeViewViewModel.earthquakeEnergy(for: earthquake.properties.magnitude)
        self.place = earthquake.properties.place
        self.dateString = EarthquakeViewViewModel.dateString(from: earthquake.properties.time)
    }
    
    private static func magnitudeString(from magnitude: Double) -> String {
        return String(format: "%.01f", magnitude)
    }
    
    private static func earthquakeEnergy(for magnitude: Double) -> EarthquakeEnergy {
        if magnitude < 4 {
            return .small
        } else if magnitude >= 4 && magnitude < 6 {
            return .moderate
        } else if magnitude >= 6 && magnitude < 8 {
            return .major
        } else {
            return .great
        }
    }
    
    private static func dateString(from timeInterval: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: timeInterval/1000)
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd, yyyy h:mm a"
        formatter.timeZone = TimeZone(abbreviation: "AST")
        return formatter.string(from: date)
    }
}
