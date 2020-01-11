//
//  MainTabView.swift
//  Temblores PR
//
//  Created by Eduardo Moll on 1/10/20.
//  Copyright © 2020 eduardo moll. All rights reserved.
//

import SwiftUI

struct MainTabView: View {
    
    let summarViewModel: SummaryViewModel
    let locationsViewModel: EarthquakeLocationsViewModel
    
    var body: some View {
        
        TabView {
            
            ContentView(viewModel: summarViewModel)
                .tabItem {
                    Image(systemName: "waveform.path.ecg")
                    Text("Earthquakes")
            }
            
            EarthquakeLocationsView(viewModel: locationsViewModel)
                .tabItem {
                    Image(systemName: "map")
                    Text("Map")
            }
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
        //        MainTabView()
    }
}
