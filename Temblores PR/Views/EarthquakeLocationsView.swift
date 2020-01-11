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
        NavigationView {
           MapView(viewModel: MapViewViewModel(coordindates: viewModel.coordinates))
            .navigationBarTitle("Earthquake Map", displayMode: .inline)
        }
        
    }
}

struct EarthquakeLocationsView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
//        EarthquakeLocationsView()
    }
}
