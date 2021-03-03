//
//  ViewModelLoadProtocol.swift
//  SwiftUI-MVVM
//
//  Created by Nick on 3/3/21.
//

import Combine

public protocol ViewModelLoadProtocol: AnyObject {
    var state: ViewModelState { get set }
    var disposables: Set<AnyCancellable> { get set }
    
    func refreshState()
    func nextState()
}
