//
//  EarthquakeService.swift
//  Temblores PR
//
//  Created by Eduardo Moll on 1/11/20.
//  Copyright © 2020 eduardo moll. All rights reserved.
//

import Foundation

enum EarthquakeEndpoint: Endpoint {
    
    case summary(_ latitude: Double, longitude: Double)
    
    var baseURL: String {
        return "https://earthquake.usgs.gov"
    }
    
    var httpMethod: HTTPMethod { .get }
    
    var path: String { "/fdsnws/event/1/query" }
    
    var parameters: [String: Any]? {
        switch self {
        case .summary(let latitude, let longitude):
            return ["format": "geojson",
                    "latitude": latitude,
                    "longitude": longitude,
                    "maxradius": 1,
                    "minmagnitude": 3,
                    "limit": 200
            ]
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
}
