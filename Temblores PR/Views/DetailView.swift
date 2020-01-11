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
        //        DetailView()
        Text("")
    }
}

struct DetailViewModel {
    
    private let earthquake: Earthquake
    
    var alert: String? {
        earthquake.properties.alert
    }
    
    var date: String {
        DetailViewModel.dateString(from: earthquake.properties.time)
    }
    
    var depth: String? {
        guard earthquake.geometry.coordinates.count == 3,
            let depth = earthquake.geometry.coordinates.last else { return nil }
        return "\(depth) km"
    }
    
    var intensity: String? {
        guard let intensity = earthquake.properties.intensity else { return nil }
        if intensity < 1.5 {
            return "I"
        } else if intensity >= 1.5 && intensity < 2.5 {
            return "II"
        } else if intensity >= 2.5 && intensity < 3.5 {
            return "III"
        } else if intensity >= 3.5 && intensity < 4.5 {
            return "IV"
        } else if intensity >= 4.5 && intensity < 5.5 {
            return "V"
        } else if intensity >= 5.5 && intensity < 6.5 {
            return "VI"
        } else if intensity >= 6.5 && intensity < 7.5 {
            return "VII"
        } else if intensity >= 7.5 && intensity < 8.5 {
            return "VIII"
        } else if intensity >= 8.5 && intensity < 9.5 {
            return "IV"
        } else {
            return "V"
        }
    }
    
    var title: String {
        earthquake.properties.title
    }
    
    var magnitude: String {
        String(format: "%0.1f", earthquake.properties.magnitude)
    }
    
    var latitude: Double {
        guard !earthquake.geometry.coordinates.isEmpty else { return 0 }
        if earthquake.geometry.coordinates[0] > 1 {
            return earthquake.geometry.coordinates[0]
        } else {
            return earthquake.geometry.coordinates[1]
        }
    }
    
    var longitude: Double {
        guard !earthquake.geometry.coordinates.isEmpty else { return 0 }
        if earthquake.geometry.coordinates[0] < 1 {
            return earthquake.geometry.coordinates[0]
        } else {
            return earthquake.geometry.coordinates[1]
        }
    }
    
    init(earthquake: Earthquake) {
        self.earthquake = earthquake
    }
    
    private static func dateString(from timeInterval: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: timeInterval/1000)
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd, yyyy h:mm a"
        formatter.timeZone = TimeZone(abbreviation: "AST")
        return formatter.string(from: date)
    }
}
