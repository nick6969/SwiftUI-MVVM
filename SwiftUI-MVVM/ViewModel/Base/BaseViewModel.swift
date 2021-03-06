//
//  BaseViewModel.swift
//  SwiftUI-MVVM
//
//  Created by Nick on 3/3/21.
//

import Foundation
import Combine

class BaseViewModel<Model: Decodable> {
    
    var state: ViewModelState = .initialize
    var disposables: Set<AnyCancellable> = []
    
    @Published var error: Error?
    @Published var isLoading: Bool = false
    @Published var models: [Model] = []
}
