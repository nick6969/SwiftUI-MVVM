//
//  ViewModelLoadProtocol.swift
//  SwiftUI-MVVM
//
//  Created by Nick on 3/3/21.
//

import Combine

public protocol ViewModelLoadProtocol: AnyObject {
    associatedtype Model

    var state: ViewModelState { get set }
    var error: Error? { get set }
    var isLoading: Bool { get set }
    var disposables: Set<AnyCancellable> { get set }
    
    func refreshState()
    func nextState()
    
    func loadData() -> AnyPublisher<[Model], Error>
    func loadDataMore() -> AnyPublisher<[Model], Error>
}
