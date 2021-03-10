//
//  APIClient.swift
//  SwiftUI-MVVM
//
//  Created by Nick on 3/3/21.
//

import Foundation
import Combine

public enum ApiError: Error {
    case badURL
}

final class APIClient {
    
    static let shared: APIClient = APIClient()
    private init() { }
    
    func run<IN: Decodable, OUT: Decodable>(
        _ request: URLRequest,
        session: URLSession = URLSession.shared,
        transform: @escaping ((IN) -> OUT),
        decoder: JSONDecoder = JSONDecoder()) -> AnyPublisher<OUT, Error> {
        return session
            .dataTaskPublisher(for: request)
            .tryMap { try decoder.decode(IN.self, from: $0.data) }
            .map(transform)
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    func run<OUT: Decodable>(
        request: URLRequest,
        session: URLSession = URLSession.shared,
        decoder: JSONDecoder = JSONDecoder()) -> AnyPublisher<OUT, Error> {
        return session
            .dataTaskPublisher(for: request)
            .tryMap { try decoder.decode(OUT.self, from: $0.data) }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
}
