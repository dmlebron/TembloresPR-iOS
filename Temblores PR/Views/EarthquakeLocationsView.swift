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
    @State private var notificationSubscriber: AnyCancellable?
    
    var body: some View {
        NavigationView {
            if self.viewModel.viewState == .error {
                EmptyStateView(title: "Error",
                               message: "Try Again Message",
                               buttonTitle: "Try Again Title",
                               buttonAction: self.loadData)
                
            } else {
                MapView(viewModel: MapViewViewModel(coordindates: viewModel.annotationData))
                .navigationBarTitle("Earthquake Map", displayMode: .inline)
            }
        }
        .onAppear {
            if self.notificationSubscriber == nil {
                self.susbcribe()
            }
        }
    }
    
    private func susbcribe() {
        notificationSubscriber = NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)
            .sink { _ in
                self.viewModel.loadLocations()
        }
    }
    
    private func loadData() {
        self.viewModel.loadLocations()
    }
}

struct EarthquakeLocationsView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}
