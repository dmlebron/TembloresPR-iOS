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
            if viewModel.earthquakes.isEmpty {
                SpinnerView()
            } else {
                List(viewModel.earthquakes, id: \.id) { earthquake in
                    NavigationLink(destination: DetailView(viewModel: DetailViewModel(earthquake: earthquake))) {
                        EarthquakeView(viewModel: EarthquakeViewViewModel(earthquake: earthquake))
                            .padding(.vertical, 8)
                    }
                }
                .navigationBarTitle(self.viewModel.title)
            }
        }
        .onAppear { self.viewModel.loadSummary() }
    }
    
    private func load() {
        self.viewModel.loadSummary(clearsAll: true)
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        EmptyView()
//        ContentView(viewModel: SummaryViewModel(earthquakeService:
//            EarthquakeService(service: NetworkService(session: .shared))
//        ))
    }
}
