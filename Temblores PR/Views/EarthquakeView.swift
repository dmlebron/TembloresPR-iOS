//
//  EarthquakeView.swift
//  Temblores PR
//
//  Created by Eduardo Moll on 1/10/20.
//  Copyright © 2020 eduardo moll. All rights reserved.
//

import SwiftUI

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

struct EarthquakeView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}
