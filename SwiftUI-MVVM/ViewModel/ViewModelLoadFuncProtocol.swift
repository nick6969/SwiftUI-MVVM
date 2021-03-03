//
//  ViewModelLoadFuncProtocol.swift
//  SwiftUI-MVVM
//
//  Created by Nick on 3/3/21.
//

import Combine

public protocol ViewModelLoadFuncProtocol: AnyObject {
    associatedtype Model
    func loadData() -> AnyPublisher<[Model], Error>
    func loadDataMore() -> AnyPublisher<[Model], Error>
}
