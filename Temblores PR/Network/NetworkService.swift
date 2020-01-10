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
    var version: String? { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var parameters: [String: Any]? { get }
    var headers: [String: String]? { get }
}

extension Endpoint {
    
    var baseURL: String { "http://localhost:8080" }
    
    var version: String? { "1.0" }
    
    func urlRequest() -> URLRequest? {
        guard let url = URL(string: baseURL + path) else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        request.allHTTPHeaderFields = headers
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters ?? [:])
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

class LoginService {
    
    let service: Network
    
    init(service: Network) {
        self.service = service
    }

    func register(username: String, password: String) -> AnyPublisher<RegisterResponse, Error> {
        let endpoint = LoginEndpoint.register(username, password)
        return service.startTransaction(for: endpoint.urlRequest()!)
            .decode(type: RegisterResponse.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}

struct RegisterResponse: Decodable {
    let success: Bool
}

enum LoginEndpoint: Endpoint {

    case register(_ username: String, _ password: String)
    
    var httpMethod: HTTPMethod {
        switch self {
        case .register(_, _):
            return .post
        }
    }
    
    var path: String {
        switch self {
        case .register(_, _):
            return "/register"
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .register(let username, let password):
            return ["username": username, "password": password]
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
}
