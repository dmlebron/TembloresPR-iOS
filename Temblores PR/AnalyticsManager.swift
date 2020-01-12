//
//  AnalyticsManager.swift
//  Temblores PR
//
//  Created by Eduardo Moll on 1/11/20.
//  Copyright © 2020 eduardo moll. All rights reserved.
//

import Foundation
import SwiftUI
import FirebaseAnalytics

protocol AnalyticsManager {
    func logEvent(with name: String, parameters: [String: Any]?)
}

class FirebaseAnalyticsManager: AnalyticsManager, ObservableObject {
    
    func logEvent(with name: String, parameters: [String: Any]? = nil) {
        Analytics.logEvent(name, parameters: parameters)
    }
}
