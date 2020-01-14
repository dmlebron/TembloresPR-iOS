//
//  EarthquakeService.swift
//  Temblores PR
//
//  Created by Eduardo Moll on 1/7/20.
//  Copyright © 2020 eduardo moll. All rights reserved.
//

import Foundation
import Combine
import CoreLocation

protocol EarthquakeApiService {
    func loadEarthQuakes() -> AnyPublisher<EarthquakeList, Error>
}

class EarthquakeService: EarthquakeApiService {
    
    let service: Network
      
      init(service: Network) {
          self.service = service
      }

      func loadEarthQuakes() -> AnyPublisher<EarthquakeList, Error> {
        let endpoint = EarthquakeEndpoint.summary(CLLocationCoordinate2D.PRCoordinates.latitude,
                                                  longitude: CLLocationCoordinate2D.PRCoordinates.longitude)
          return service.startTransaction(for: endpoint.urlRequest()!)
              .decode(type: EarthquakeList.self, decoder: JSONDecoder())
              .eraseToAnyPublisher()
      }
    
}
