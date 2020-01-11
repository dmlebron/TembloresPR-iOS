//
//  EarthquakeService.swift
//  Temblores PR
//
//  Created by Eduardo Moll on 1/7/20.
//  Copyright © 2020 eduardo moll. All rights reserved.
//

import Foundation
import Combine

class EarthquakeService {
    
    let service: Network
      
      init(service: Network) {
          self.service = service
      }

      func loadEarthQuakes() -> AnyPublisher<EarthquakeList, Error> {
        let endpoint = EarthquakeEndpoint.summary(18.4655, longitude: -66.1067)
          return service.startTransaction(for: endpoint.urlRequest()!)
              .decode(type: EarthquakeList.self, decoder: JSONDecoder())
              .eraseToAnyPublisher()
      }
    
}
