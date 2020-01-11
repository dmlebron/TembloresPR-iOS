//
//  NetworkService.swift
//  Tiollo
//
//  Created by Moll, Eduardo on 12/16/19.
//  Copyright © 2019 Moll, Eduardo. All rights reserved.
//

import Foundation
import Combine

enum HTTPMethod: String {
    case get
    case post
}

protocol Endpoint {
    var baseURL: String { get }
    var version: String? { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var parameters: [String: Any]? { get }
    var headers: [String: String]? { get }
}

extension Endpoint {
            
    var version: String? { "1.0" }
    
    func urlRequest() -> URLRequest? {
        guard var urlComponents = URLComponents(string: baseURL + path) else { return nil }
        let queryItems = parameters?.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
        urlComponents.queryItems = queryItems
        guard let url = urlComponents.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        request.allHTTPHeaderFields = headers
        return request
    }
}

protocol Network {
    func startTransaction(for request: URLRequest) -> AnyPublisher<Data, URLError>
}

class NetworkService: Network {
    
    let session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    func startTransaction(for request: URLRequest) -> AnyPublisher<Data, URLError> {
        session.dataTaskPublisher(for: request)
        .map { $0.data }
        .eraseToAnyPublisher()
    }
}

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
