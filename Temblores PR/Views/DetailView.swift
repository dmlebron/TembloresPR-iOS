//
//  DetailView.swift
//  Temblores PR
//
//  Created by Eduardo Moll on 1/7/20.
//  Copyright © 2020 eduardo moll. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    
    @State private var isShowingBottomSheet = false
    
    private let viewModel: DetailViewModel
    
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        GeometryReader { geometry in
            MapView(latitude: self.viewModel.latitude, longitude: self.viewModel.longitude)
            BottomSheetView(isOpen: self.$isShowingBottomSheet, maxHeight: geometry.size.height * 0.9) {

                Group {
                    VStack(spacing: 16) {
                        InfoView(title: "Date", detail: self.viewModel.date)
                        Divider()
                        
                        InfoView(title: "Magnitude", detail: self.viewModel.magnitude)
                        Divider()
                    }
                    
                    VStack(spacing: 16) {
                        if self.viewModel.depth != nil {
                            InfoView(title: "Depth", detail: self.viewModel.depth!)
                            Divider()
                        }
                    
                        if self.viewModel.intensity != nil {
                            InfoView(title: "Intensity", detail: self.viewModel.intensity!)
                            Divider()
                        }
                        
                        if self.viewModel.alert != nil {
                            InfoView(title: "Alert", detail: self.viewModel.alert!)
                            Divider()
                        }
                    }

                    VStack(spacing: 16) {
                        InfoView(title: "Latitude", detail: "\(self.viewModel.latitude)")
                        Divider()
                        
                        InfoView(title: "Longitude", detail: "\(self.viewModel.longitude)")
                    }
                }
            }
            .edgesIgnoringSafeArea(.all)
            .navigationBarTitle("\(self.viewModel.title)", displayMode: .inline)
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        Text("")
    }
}
