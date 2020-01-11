//
//  EarthquakeEnergy.swift
//  Temblores PR
//
//  Created by Eduardo Moll on 1/10/20.
//  Copyright © 2020 eduardo moll. All rights reserved.
//

import Foundation
import SwiftUI

enum EarthquakeEnergy {
    case small
    case moderate
    case major
    case great
    
    var color: Color {
        switch self {
        case .small:
            return .green
        case .moderate:
            return .yellow
        case .major:
            return .orange
        case .great:
            return .red
        }
    }
}
