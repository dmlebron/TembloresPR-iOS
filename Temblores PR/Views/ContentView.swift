//
//  ContentView.swift
//  Temblores PR
//
//  Created by Eduardo Moll on 1/7/20.
//  Copyright © 2020 eduardo moll. All rights reserved.
//

import SwiftUI
import Combine
import FirebaseAnalytics

enum ViewState {
    case loading
    case loaded
    case error
}

struct ContentView: View {
    
    @ObservedObject private var viewModel: SummaryViewModel
    @State private var notificationSubscriber: AnyCancellable?
    @State private var isFirstLoad = true
    
    init(viewModel: SummaryViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            if viewModel.viewState == .loading {
                SpinnerView()
            } else if viewModel.viewState == .loaded {
                List(viewModel.earthquakes, id: \.id) { earthquake in
                    NavigationLink(destination: DetailView(viewModel: DetailViewModel(earthquake: earthquake))) {
                        EarthquakeView(viewModel: EarthquakeViewViewModel(earthquake: earthquake))
                            .padding(.vertical, 8)
                    }
                }
                .navigationBarTitle(self.viewModel.title)
            } else if viewModel.viewState == .error {
                EmptyStateView(title: "Error",
                               message: "Try Again Message",
                               buttonTitle: "Try Again",
                               buttonAction: self.loadData)
            }
        }
        .onAppear {
            if self.isFirstLoad {
                self.viewModel.loadSummary()
                self.isFirstLoad = false
            }
        }
        .onAppear {
            if self.notificationSubscriber == nil {
                self.susbcribe()
            }
        }
    }
    
    private func susbcribe() {
        notificationSubscriber = NotificationCenter.default
            .publisher(for: UIApplication.willEnterForegroundNotification)
            .sink { _ in
                if self.viewModel.viewState != .loading {
                    self.viewModel.loadSummary(clearsAll: true)
                }
        }
    }
    
    private func loadData() {
        self.viewModel.loadSummary()
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        EmptyView()
    }
}
